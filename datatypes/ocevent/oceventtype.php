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

            $data_array['input'] = json_decode($data['input'], true);
            $data_array['text'] = $data['text'];
            $data_array['recurrences'] = json_decode($data['recurrences'], true);
            $data_array['events'] = json_decode($data['events'], true);

            if (count($data_array) > 0) {
                $jsonString = json_encode($data_array);
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
        $data['input_json'] = json_encode($data['input']);
        $data['recurrences_json'] = json_encode($data['recurrences']);
        $data['events_json'] = json_encode($data['events']);
        return $data;
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
        if ($dataText != ''){
            $data = json_decode($dataText, true);
            if (isset($data['events'])){
                return count($data['events']) > 0;
            }
        }

        return false;
    }

    /**
     * Return string representation of an contentobjectattribute data for simplified export
     *
     * @param eZContentObjectAttribute $contentObjectAttribute
     * @return string
     */
    function toString($contentObjectAttribute)
    {
        return $contentObjectAttribute->attribute('data_text');
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
     * @param $now
     * @param $version
     * @param $checktime1
     * @param bool $checktime2
     * @return array
     */
    function validateDateTime($now, $version, $checktime1, $checktime2 = false)
    {
        if ($checktime1 instanceof DateTime && ($checktime2 === false || ($checktime2 !== false && $checktime2 instanceof DateTime))) {
            if ($checktime2 !== false) {
                $maxPeriodForEvent = '+1 year';


                if ($checktime2->getTimestamp() < $now && $version !== false && $version->Version == 1) {
                    return array('error' => ezpI18n::tr('extension/ocevents', 'Select an end date in the future.'));
                }

                if ($checktime1->getTimestamp() > $checktime2->getTimestamp()) {
                    return array('error' => ezpI18n::tr('extension/ocevents', 'Select an end date newer then the start date.'));
                }

                $tmpChecktime1 = clone $checktime1;
                $tmpChecktime1->modify($maxPeriodForEvent);
                if ($tmpChecktime1->getTimestamp() < $checktime2->getTimestamp()) {
                    return array('error' => ezpI18n::tr('extension/ocevents', 'Maximum period of an event is exceeded.'));
                }
            }
        } else {
            if (!$checktime1 instanceof DateTime) {
                return array('error' => ezpI18n::tr('extension/ocevents', 'Start date is not instanceof DateTime.'));
            }
            if ($checktime2 !== false && !$checktime2 instanceof DateTime) {
                return array('error' => ezpI18n::tr('extension/ocevents', 'End date is not instanceof DateTime.'));
            }
        }
        return array('state' => true);
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
