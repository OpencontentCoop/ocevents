<?php

use Opencontent\Opendata\Api\Values\SearchResults;
use Opencontent\Opendata\Api\QueryLanguage\EzFind\QueryBuilder;
use Opencontent\Opendata\Api\Values\Content;

class OcEventsFullcalendarEnvironmentSettings extends DefaultEnvironmentSettings
{
    protected $maxSearchLimit = 300;

    public function filterContent(Content $content)
    {
        return $content;
    }

    /**
     * @see https://fullcalendar.io/docs/event_data/events_json_feed/
     *
     * @param SearchResults $searchResults
     * @param ArrayObject $query
     * @param QueryBuilder $builder
     *
     * @return array
     */
    public function filterSearchResult(
        \Opencontent\Opendata\Api\Values\SearchResults $searchResults,
        \ArrayObject $query,
        \Opencontent\QueryLanguage\QueryBuilder $builder
    )
    {
        //return parent::filterSearchResult($searchResults, $query, $builder);
        $events = [];
        if ($searchResults->totalCount > 0) {
            foreach ($searchResults->searchHits as $content) {
                $events = array_merge($events, $this->convertContentToFullcalendarItem($content));
            }
        }
        return $events;
    }

    private function convertContentToFullcalendarItem(Content $content)
    {
        $parameters = $this->request->get;
        $startRequest = new DateTime($parameters['start'], new \DateTimeZone('UTC'));
        $endRequest = new DateTime($parameters['end'], new \DateTimeZone('UTC'));

        $data = $this->getFirstLocale($content->data);
        $recurrences = array();
        $recurrencesData = $data['recurrences']['content'];

        $eventId = $content->metadata->id;
        $eventTitle = $this->getFirstLocale($content->metadata->name);
        $eventContent = parent::filterContent($content);

        foreach ($recurrencesData['events'] as $k => $v) {

            $from = $v['start'];
            $to = $v['end'];
            $allDay = false;

            $fromDateTime = DateTime::createFromFormat(DateTime::ISO8601, $from);
            $toDateTime = DateTime::createFromFormat(DateTime::ISO8601, $to);

            if ($fromDateTime instanceof DateTime && $toDateTime instanceof DateTime) {

                if (
                    ($fromDateTime >= $startRequest && $fromDateTime <= $endRequest)
                    || ($toDateTime >= $startRequest && $toDateTime <= $endRequest)
                    || ($fromDateTime <= $endRequest && $toDateTime >= $startRequest)
                ) {

                    $diff = $toDateTime->diff($fromDateTime);
                    if ($diff instanceof DateInterval) {
                        $allDay = (bool)$diff->days;
                    }

                    $event = new OcEventsFullCalendarEvent();
                    $event->setId($eventId)
                        ->setTitle($eventTitle)
                        ->setStart($from)
                        ->setEnd($to)
                        ->setAllDay($allDay)
                        ->setContent($eventContent);

                    $recurrences[] = $event;
                }
            }
        }
        return $recurrences;
    }

    private function getFirstLocale($value)
    {
        $language = eZLocale::currentLocaleCode();
        return isset($value[$language]) ? $value[$language] : array_shift($value);
    }

    /**
     * @see https://fullcalendar.io/docs/event_data/events_json_feed/
     *
     * @param ArrayObject $query
     * @param QueryBuilder $builder
     *
     * @return ArrayObject
     */
    public function filterQuery(
        \ArrayObject $query,
        \Opencontent\QueryLanguage\QueryBuilder $builder
    )
    {
        $parameters = $this->request->get;
        $start = $parameters['start'];
        $end = $parameters['end'];
        $calendarQuery = "calendar[] = [$start,$end]";
        $queryObject = $builder->instanceQuery($calendarQuery);
        $calendarQuery = $queryObject->convert();

        $currentFilter = $query['Filter'];
        if (!empty($currentFilter))
            $query['Filter'] = array($currentFilter, $calendarQuery->getArrayCopy()['Filter']);
        else
            $query['Filter'] = $calendarQuery->getArrayCopy()['Filter'];

        if (isset($query['SearchLimit'])) {
            if ($query['SearchLimit'] > $this->maxSearchLimit) {
                $query['SearchLimit'] = $this->maxSearchLimit;
            }
        } else {
            $query['SearchLimit'] = $this->maxSearchLimit;
        }

        if (!isset($query['SearchOffset'])) {
            $query['SearchOffset'] = 0;
        }

        return $query;
    }
}
