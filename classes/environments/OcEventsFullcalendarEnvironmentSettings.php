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

    $data = $this->getFirstLocale($content->data);
    $recurrences = array();
    $recurrences_data = $data['recurrences']['content'];

    $eventId      = $content->metadata->id;
    $eventTitle   = $this->getFirstLocale($content->metadata->name);
    $eventContent = parent::filterContent($content);

    foreach ($recurrences_data['events'] as $k => $v) {

      $from = $v['start'];
      $to = $v['end'];
      $allDay = false;

      if ($to) {
        $fromDateTime = DateTime::createFromFormat(DateTime::ISO8601, $from);
        $toDateTime = DateTime::createFromFormat(DateTime::ISO8601, $to);

        // Todo: Verificare che la ricoorennza cada nel periodo passato
        if ($fromDateTime instanceof DateTime && $toDateTime instanceof DateTime) {
          $diff = $toDateTime->diff($fromDateTime);
          if ($diff instanceof DateInterval) {
            $allDay = (bool)$diff->days;
          }
        }
      }

      $event = new OcEventsFullCalendarEvent();
      $event->setId($eventId)
        ->setTitle($eventTitle)
        ->setStart($from)
        ->setEnd($to)
        ->setAllDay($allDay)
        ->setContent($eventContent);

      $recurrences [] = $event;
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
    $start = strtotime($parameters['start']);
    $end = strtotime($parameters['end']);
    $calendarQuery = 'raw[' . OCRecurrenceHelper::SOLR_FIELD_NAME . '] = "Intersects\(' . OCRecurrenceHelper::MIN_BOUND . ' ' . $start . ' ' . $end . ' ' . OCRecurrenceHelper::MAX_BOUND . '\)"';

    $queryObject = $builder->instanceQuery($calendarQuery);
    $calendarQuery = $queryObject->convert();
    $query = new ArrayObject(
      array_merge_recursive($query->getArrayCopy(), $calendarQuery->getArrayCopy())
    );

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
