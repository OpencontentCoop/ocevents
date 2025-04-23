<?php

class OCEventType extends eZDataType
{
    const DATA_TYPE_STRING = 'ocevent';
    const DEFAULT_FIELD = 'data_text';

    function __construct()
    {
        $this->eZDataType(
            self::DATA_TYPE_STRING,
            ezpI18n::tr('ocevents/attribute', 'Recurrent event', 'Datatype name'),
            array('serialize_supported' => true)
        );
    }

    /**
     * Validates the input and returns true if the input was valid for this datatype.
     *
     * @param eZHTTPTool $http
     * @param string $base
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @return int
     */
    function validateObjectAttributeHTTPInput($http, $base, $contentObjectAttribute)
    {
        if ($http->hasPostVariable($base . '_ocevent_data_' . $contentObjectAttribute->attribute('id'))) {
            $data = $http->postVariable($base . '_ocevent_data_' . $contentObjectAttribute->attribute('id'));

            $dataArray['input'] = json_decode($data['input'], true);
            $dataArray['text'] = $data['text'];
            $dataArray['recurrences'] = json_decode($data['recurrences'], true);
            $dataArray['events'] = json_decode($data['events'], true);

            if (count($dataArray['events']) == 0 && $contentObjectAttribute->validateIsRequired()) {
                $contentObjectAttribute->setValidationError(ezpI18n::tr('kernel/classes/datatypes', 'Input required.'));
                return eZInputValidator::STATE_INVALID;
            }

            if (count($dataArray) > 0) {
                $jsonString = json_encode($dataArray);
                $contentObjectAttribute->setAttribute('data_text', $jsonString);
            }
        }
        return eZInputValidator::STATE_ACCEPTED;
    }

    /**
     * Avoid multiple ocevent datatype
     *
     * @param eZHTTPTool $http
     * @param string $base
     * @param eZContentClassAttribute $classAttribute
     *
     * @return int
     */
    function validateClassAttributeHTTPInput($http, $base, $classAttribute)
    {
        if ($http->hasPostVariable('StoreButton') || $http->hasPostVariable('ApplyButton')) {

            // find the class and count how many recurrence datatype
            $cond = array('contentclass_id' => $classAttribute->attribute('contentclass_id'),
                'version' => eZContentClass::VERSION_STATUS_TEMPORARY,
                'data_type_string' => $classAttribute->attribute('data_type_string'));

            /** @var eZContentClassAttribute[] $classAttributeList */
            $classAttributeList = eZContentClassAttribute::fetchFilteredList($cond);

            // if there is more than 1 recurrence attribute, return it as INVALID
            if (!is_null($classAttributeList) && count($classAttributeList) > 1) {
                if ($classAttributeList[0]->attribute('id') == $classAttribute->attribute('id')) {
                    eZDebug::writeNotice('There are more than 1 recurrence attribute in the class.', __METHOD__);
                    return eZInputValidator::STATE_INVALID;
                }
            }
        }
        return eZInputValidator::STATE_ACCEPTED;
    }

    /*!
     Fetches the http post var integer input and stores it in the data instance.
    */
    function fetchObjectAttributeHTTPInput($http, $base, $contentObjectAttribute)
    {
        return true;
    }

    /**
     * Returns the content.
     *
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @return mixed|string
     */
    function objectAttributeContent($contentObjectAttribute)
    {
        $data = json_decode($contentObjectAttribute->attribute('data_text'), true);
        if (!$data) {
            $data = array(
                'input' => array(),
                'recurrences' => array(),
                'events' => array(),
            );
        }
        $data['input'] = array_merge($this->getDefaultInputVal(), $data['input']);
        $data['input_json'] = json_encode($data['input']);
        $data['recurrences_json'] = json_encode($data['recurrences']);
        $data['events_json'] = json_encode($data['events']);

        return $data;
    }

    private function getDefaultInputVal()
    {
        return array(
            'startDateTime' => false,
            'endDateTime' => false,
            'freq' => 'none',
            'byweekday' => [],
            'until' => false,
            'interval' => false,
            'recurrencePattern' => '',
            'timeZone' => array(
                'offset' => 0
            )
        );
    }

    /**
     * Ritorna l'inizio del primo evento e la fine dell'ultimo (per evitare che ocSolrDocumentFieldObjectRelation dia errore)
     *
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @return string|null
     */
    function metaData($contentObjectAttribute)
    {
        /*
        Questo metodo viene chiamato da ocSolrDocumentFieldObjectRelation e produce un errore nel caso in cui ocevents sia un sub-attribute
        L'errore è "Error adding field 'subattr_sub_event_of___time_interval____si'='1562911200.01 1563134400.01' msg=For input string: "1562911200.01 1563134400.01"
        Il metadato negli altri casi viene comunque gestito da ezfSolrDocumentFieldOcEvent
        */

        return null;
    }

    public static function getDatePoints($contentObjectAttribute)
    {
        $datePoints = array();
        $content = json_decode($contentObjectAttribute->attribute('data_text'), true);
        foreach ((array)$content['events'] as $event) {
            try {
                $start = self::parseDate($event['start']);
                $end = self::parseDate($event['end']);

                if (!is_null($start) && !is_null($end)) {
                    // @todo @fixme aggiungiamo .01 per evitare l'eccezione da parte di solr, da capire
                    $datePoints[] = (string)$start . '.01' . ' ' . $end . '.01';

                }
            } catch (Exception $e) {
                eZDebug::writeError($e->getMessage(), __METHOD__);
            }
        }

        return $datePoints;
    }

    /**
     * @param $inputDate
     * @param string $format
     * @return null|string
     * @throws Exception
     *
     * Il formato della data passata è 2017-10-20T10:37:06+02:00
     */
    private static function parseDate($inputDate, $format = DateTime::ISO8601)
    {
        if ($inputDate == null) {
            return null;
        }

        $dateTime = DateTime::createFromFormat($format, $inputDate);
        if ($dateTime instanceOf DateTime) {
            return $dateTime->format('U');
        }
        return null;
    }

    /**
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @return bool
     */
    function hasObjectAttributeContent($contentObjectAttribute)
    {
        $dataText = $contentObjectAttribute->attribute("data_text");
        if ($dataText != '') {
            $data = json_decode($dataText, true);
            if (isset($data['events'])) {
                return count($data['events']) > 0;
            }
        }

        return false;
    }

    /**
     * Return string representation of an contentobjectattribute data for simplified export
     * recurrence_pattern#start_timestamp-end__timestamp|start_timestamp-end__timestamp|...
     * example: DTSTART=20200115T090000Z;DTEND=20200115T110000Z;FREQ=DAILY;INTERVAL=1;UNTIL=20200130T230000Z#1579078800-1579086000|1579165200-1579172400|...
     *
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @return string
     */
    function toString($contentObjectAttribute)
    {
        $content = $contentObjectAttribute->content();
        $string = $content['input']['recurrencePattern'];
        if ($content['recurrences_json'] != $content['events_json']) {
            $eventList = array();
            foreach ($content['events'] as $event) {
                $eventList[] = strtotime($event['start']) . '-' . strtotime($event['end']);
            }
            $string .= '#' . implode('|', $eventList);
        }

        return $string;
    }

    /**
     * recurrence_pattern#start_timestamp-end__timestamp|start_timestamp-end__timestamp|...
     * example: DTSTART=20200115T090000Z;DTEND=20200115T110000Z;FREQ=DAILY;INTERVAL=1;UNTIL=20200130T230000Z#1579078800-1579086000|1579165200-1579172400|...
     *
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @param $string
     */
    function fromString($contentObjectAttribute, $string)
    {
        $parts = explode('#', $string);
        $pattern = $parts[0];
        $customEvents = isset($parts[1]) ? explode('|', $parts[1]) : array();

        try {
            $rule = new Recurr\Rule($pattern);
            $helperData = array(
                'startDateTime' => $rule->getStartDate() ? $rule->getStartDate()->format('Y-m-d\TH:i:sP') : null,
                'endDateTime' => $rule->getEndDate() ? $rule->getEndDate()->format('Y-m-d\TH:i:sP') : null,
                'until' => $rule->getUntil() ? $rule->getUntil()->format('Y-m-d\TH:i:sP') : null,
                'timeZone' => array(
                    'offset' => $rule->getStartDate() ? $rule->getStartDate()->format('P') : 0
                ),
                'recurrencePattern' => $pattern
            );

            $helper = new OCRecurrenceHelper($helperData);
            $events = $recurrences = $helper->getFullCalendarRecurrences();
            $text = $helper->getText();

            $input = $this->getDefaultInputVal();
            if ($rule->getStartDate()) {
                $input['startDateTime'] = $rule->getStartDate()->format('c');
                $input['timeZone']['offset'] = $rule->getStartDate()->format('P');
            }
            if ($rule->getEndDate()) {
                $input['endDateTime'] = $rule->getEndDate()->format('c');
            }
            if ($rule->getUntil()) {
                $input['until'] = $rule->getUntil()->format('c');
            }
            if ($rule->getFreq()) {
                $input['freq'] = $rule->getUntil() ? $rule->getFreq() : "none";
            }
            if ($rule->getInterval()) {
                $input['interval'] = $rule->getInterval();
            }
            if ($rule->getByDay()) {
                /** @var \Recurr\Weekday[] $weekDays */
                $weekDays = $rule->getByDayTransformedToWeekdays();
                foreach ($weekDays as $weekDay) {
                    $input['byweekday'][] = $weekDay->weekday;
                }
            }
            $input['recurrencePattern'] = $pattern;

            if (count($customEvents) > 0) {
                $events = array();
                foreach ($customEvents as $customEvent) {
                    list($start, $end) = explode('-', $customEvent);
                    $events[] = array(
                        'id' => $start . '-' . $end,
                        'start' => date(DateTime::RFC3339, $start),
                        'end' => date(DateTime::RFC3339, $end)
                    );
                }
            }

            $dataArray['input'] = $input;
            $dataArray['text'] = $text;
            $dataArray['recurrences'] = $recurrences;
            $dataArray['events'] = $events;

            $jsonString = json_encode($dataArray);
            $contentObjectAttribute->setAttribute('data_text', $jsonString);

        } catch (Exception $e) {
            eZDebug::writeError($e->getMessage(), __METHOD__);
        }
    }

    /**
     * Sets the default value.
     *
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @param int $currentVersion
     * @param eZContentObjectAttribute $originalContentObjectAttribute
     */
    function initializeObjectAttribute($contentObjectAttribute, $currentVersion, $originalContentObjectAttribute)
    {
        $contentObjectAttribute->setAttribute("data_text", $originalContentObjectAttribute->attribute("data_text"));
    }

    /**
     * @return bool
     */
    function isIndexable()
    {
        return true;
    }

}

eZDataType::register(OCEventType::DATA_TYPE_STRING, "OCEventType");
