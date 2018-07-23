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
        $data[$fieldName] = $this->ContentObjectAttribute->metaData();

        return $data;
    }

}
