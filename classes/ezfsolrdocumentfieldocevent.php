<?php

class ezfSolrDocumentFieldOcEvent extends ezfSolrDocumentFieldBase
{
    static $customTypeField = array (
        'count' => 'sint'
    );


    /**
     * @see ezfSolrDocumentFieldBase::getFieldName()
     *
     * @param eZContentClassAttribute $classAttribute
     * @param null $subAttribute
     * @param string $context
     * @return null|string
     */
    public static function getFieldName(eZContentClassAttribute $classAttribute, $subAttribute = null, $context = 'search')
    {
        OCRecurrenceHelper::addSolrFieldTypeMap();
        switch ($classAttribute->attribute('data_type_string')) {
            case OCEventType::DATA_TYPE_STRING:
                if ($subAttribute and $subAttribute !== '') {
                    // A subattribute was passed
                    return parent::generateSubattributeFieldName(
                        $classAttribute,
                        $subAttribute,
                        OCRecurrenceHelper::DEFAULT_SUBATTRIBUTE_TYPE
                    );
                } else {
                    // return the default field name here.
                    return self::generateAttributeFieldName(
                        $classAttribute,
                        self::getClassAttributeType($classAttribute, null, $context)
                    );
                }
                break;

            default:
                return null;
                break;
        }
    }

    /**
     * Get Solr schema field type from eZContentClassAttribute.
     *
     * @param eZContentClassAttribute Instance of eZContentClassAttribute.
     * @param $subAttribute string In case the type of a datatype's sub-attribute is requested,
     *                             the subattribute's name is passed here.
     *
     * @return string Field type. Null if no field type is defined.
     */
    static function getClassAttributeType( eZContentClassAttribute $classAttribute, $subAttribute = null, $context = 'search' )
    {
        $ezFindINI = eZINI::instance('ezfind.ini');
        OCRecurrenceHelper::addSolrFieldTypeMap();
        $datatypeString = $classAttribute->attribute( 'data_type_string' );
        $customMapList = $ezFindINI->variable( 'SolrFieldMapSettings', 'CustomMap' );

        // Fallback #1: single-fielded datatype behaviour here.
        $datatypeMapList = $ezFindINI->variable( 'SolrFieldMapSettings', eZSolr::$fieldTypeContexts[$context] );
        if ( !empty( $datatypeMapList[$classAttribute->attribute( 'data_type_string' )] ) )
        {
            return $datatypeMapList[$classAttribute->attribute( 'data_type_string' )];
        }
        // Fallback #2: search field datatypemap (pre ezfind 2.2 behaviour)
        $datatypeMapList = $ezFindINI->variable( 'SolrFieldMapSettings', 'DatatypeMap' );
        if ( !empty( $datatypeMapList[$classAttribute->attribute( 'data_type_string' )] ) )
        {
            return $datatypeMapList[$classAttribute->attribute( 'data_type_string' )];
        }
        // Fallback #3: return default field.
        return $ezFindINI->variable( 'SolrFieldMapSettings', 'Default' );
    }

    /**
     * @param eZContentClassAttribute $classAttribute
     * @param string $type
     * @return string
     */
    public static function generateAttributeFieldName(eZContentClassAttribute $classAttribute, $type)
    {
        OCRecurrenceHelper::addSolrFieldTypeMap();
        return parent::generateAttributeFieldName($classAttribute, $type);
    }


    static function getCustomFieldName(eZContentClassAttribute $classAttribute, $subattribute = null)
    {
      $type = self::$customTypeField[$subattribute];
      OCRecurrenceHelper::addSolrFieldTypeMap();
      return parent::$DocumentFieldName->lookupSchemaName( self::ATTR_FIELD_PREFIX . $classAttribute->attribute( 'identifier' ) . $subattribute, $type );
    }


    /**
     * @see ezfSolrDocumentFieldBase::getData()
     */
    public function getData()
    {
        $data = array();
        $contentClassAttribute = $this->ContentObjectAttribute->attribute('contentclass_attribute');
        $datePoints = OCEventType::getDatePoints($this->ContentObjectAttribute);

        $searchFieldName = self::generateAttributeFieldName($contentClassAttribute, OCRecurrenceHelper::DEFAULT_SUBATTRIBUTE_TYPE);
        $data[$searchFieldName] = $datePoints;

        if (isset($datePoints[0])){
            $firstStartEnd = explode(' ', $datePoints[0]);
            $sortFieldName = self::generateAttributeFieldName($contentClassAttribute, 'sint');
            $data[$sortFieldName] = (int)$firstStartEnd[0];
        }

        if (!empty($datePoints)){
          $countFieldName = self::getCustomFieldName($contentClassAttribute, 'count');
          $data[$countFieldName] = (int)count($datePoints);
        }

        return $data;
    }

}
