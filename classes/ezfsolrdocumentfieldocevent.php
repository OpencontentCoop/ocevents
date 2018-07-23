<?php

class ezfSolrDocumentFieldOcEvent extends ezfSolrDocumentFieldBase
{
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
        OCRecurrenceHelper::addSolrFieldTypeMap();
        $datatypeString = $classAttribute->attribute( 'data_type_string' );
        $customMapList = ezfSolrDocumentFieldBase::$FindINI->variable( 'SolrFieldMapSettings', 'CustomMap' );

        // Fallback #1: single-fielded datatype behaviour here.
        $datatypeMapList = ezfSolrDocumentFieldBase::$FindINI->variable( 'SolrFieldMapSettings', eZSolr::$fieldTypeContexts[$context] );
        if ( !empty( $datatypeMapList[$classAttribute->attribute( 'data_type_string' )] ) )
        {
            return $datatypeMapList[$classAttribute->attribute( 'data_type_string' )];
        }
        // Fallback #2: search field datatypemap (pre ezfind 2.2 behaviour)
        $datatypeMapList = ezfSolrDocumentFieldBase::$FindINI->variable( 'SolrFieldMapSettings', 'DatatypeMap' );
        if ( !empty( $datatypeMapList[$classAttribute->attribute( 'data_type_string' )] ) )
        {
            return $datatypeMapList[$classAttribute->attribute( 'data_type_string' )];
        }
        // Fallback #3: return default field.
        return ezfSolrDocumentFieldBase::$FindINI->variable( 'SolrFieldMapSettings', 'Default' );
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

    /**
     * @see ezfSolrDocumentFieldBase::getData()
     */
    public function getData()
    {
        $data = array();
        $contentClassAttribute = $this->ContentObjectAttribute->attribute('contentclass_attribute');
        $fieldName = self::generateAttributeFieldName($contentClassAttribute, OCRecurrenceHelper::DEFAULT_SUBATTRIBUTE_TYPE);
        $data[$fieldName] = OCEventType::getDatePoints($this->ContentObjectAttribute);

        return $data;
    }

}
