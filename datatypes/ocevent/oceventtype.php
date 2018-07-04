<?php

class OCEventType extends eZDataType
{
    const DATA_TYPE_STRING = 'ocevent';
    const DEFAULT_FIELD = 'data_text';

    function __construct()
    {
        $this->eZDataType( self::DATA_TYPE_STRING, ezpI18n::tr( 'ocevents/attribute', 'Recurrent event', 'Datatype name' ),
                           array( 'serialize_supported' => true ) );
    }

    /*!
     Validates the input and returns true if the input was
     valid for this datatype.
    */
    function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        if ( $http->hasPostVariable( $base . '_ocevent_data_' . $contentObjectAttribute->attribute( 'id' ) ) )
        {
            $data    = $http->postVariable( $base . '_ocevent_data_' . $contentObjectAttribute->attribute( 'id' ) );
            $version = $contentObjectAttribute->attribute( 'object_version' );



            $data_array['input'] = json_decode( $data['input'], true );
            $data_array['text'] = $data['text'];
            $data_array['recurrences'] = json_decode( $data['recurrences'], true );
            $data_array['events'] = json_decode( $data['events'], true );

            if( count( $data_array ) > 0 )
            {
                $jsonString = json_encode( $data_array );
                $contentObjectAttribute->setAttribute( 'data_text', $jsonString );
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
    function validateClassAttributeHTTPInput( $http, $base, $classAttribute )
    {
        if ( $http->hasPostVariable( 'StoreButton' ) || $http->hasPostVariable( 'ApplyButton' ) )
        {
            // find the class and count how many recurrence datatype
            $cond = array( 'contentclass_id' => $classAttribute->attribute( 'contentclass_id' ),
                           'version' => eZContentClass::VERSION_STATUS_TEMPORARY,
                           'data_type_string' => $classAttribute->attribute( 'data_type_string' ) );
            /** @var eZContentClassAttribute[] $classAttributeList */
            $classAttributeList = eZContentClassAttribute::fetchFilteredList( $cond );
            // if there is more than 1 recurrence attribute, return it as INVALID
            if ( !is_null( $classAttributeList ) && count( $classAttributeList ) > 1 )
            {
                if ( $classAttributeList[0]->attribute( 'id' ) == $classAttribute->attribute( 'id' ) )
                {
                    eZDebug::writeNotice( 'There are more than 1 recurrence attribute in the class.', __METHOD__ );
                    return eZInputValidator::STATE_INVALID;
                }
            }
        }
        return eZInputValidator::STATE_ACCEPTED;
    }

    /*!
     Fetches the http post var integer input and stores it in the data instance.
    */
    function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        return true;
    }

    /*!
     Returns the content.
    */
    function objectAttributeContent( $contentObjectAttribute )
    {
        $data = json_decode( $contentObjectAttribute->attribute( 'data_text' ), true );
        $data ['input_json'] = json_encode($data['input']);
        $data ['recurrences_json'] = json_encode($data['recurrences']);
        $data ['events_json'] = json_encode($data['events']);
        return $data;
    }

    /*
     * Returns the meta data used for storing search indeces.
     */
    function metaData( $contentObjectAttribute )
    {
        $content = json_decode( $contentObjectAttribute->attribute( 'data_text' ), true );
        return json_encode($content['events']);
    }

    function hasObjectAttributeContent( $contentObjectAttribute )
    {
        return $contentObjectAttribute->attribute( "data_text" ) != '';
    }

    /*
     * Return string representation of an contentobjectattribute data for simplified export
     */
    function toString( $contentObjectAttribute )
    {
        return $contentObjectAttribute->attribute( 'data_text' );
    }

    /*!
     Sets the default value.
    */
    function initializeObjectAttribute( $contentObjectAttribute, $currentVersion, $originalContentObjectAttribute )
    {
        $contentObjectAttribute->setAttribute( "data_text", $originalContentObjectAttribute->attribute( "data_text" ) );
    }


    /**
     * @param $now
     * @param $version
     * @param $checktime1
     * @param bool $checktime2
     * @return array
     */
    function validateDateTime( $now, $version, $checktime1, $checktime2 = false)
    {
        if( $checktime1 instanceof DateTime && ( $checktime2 === false || ( $checktime2 !== false && $checktime2 instanceof DateTime ) ) )
        {
            if( $checktime2 !== false )
            {
                $maxPeriodForEvent = '+1 year';


                if( $checktime2->getTimestamp() < $now && $version !== false && $version->Version == 1 )
                {
                    return array( 'error' => ezpI18n::tr( 'extension/ocevents', 'Select an end date in the future.' ) );
                }

                if( $checktime1->getTimestamp() > $checktime2->getTimestamp() )
                {
                    return array( 'error' => ezpI18n::tr( 'extension/ocevents', 'Select an end date newer then the start date.' ) );
                }

                $tmpChecktime1 = clone $checktime1;
                $tmpChecktime1->modify( $maxPeriodForEvent );
                if( $tmpChecktime1->getTimestamp() < $checktime2->getTimestamp() )
                {
                    return array( 'error' => ezpI18n::tr( 'extension/ocevents', 'Maximum period of an event is exceeded.' ) );
                }
            }
        }
        else
        {
            if( !$checktime1 instanceof DateTime )
            {
                return array( 'error' => ezpI18n::tr( 'extension/ocevents', 'Start date is not instanceof DateTime.' ) );
            }
            if( $checktime2 !== false && !$checktime2 instanceof DateTime )
            {
                return array( 'error' => ezpI18n::tr( 'extension/ocevents', 'End date is not instanceof DateTime.' ) );
            }
        }
        return array( 'state' => true );
    }

    /**
     * @return bool
     */
    function isIndexable()
    {
        return true;
    }


}

eZDataType::register( OCEventType::DATA_TYPE_STRING, "OCEventType" );
