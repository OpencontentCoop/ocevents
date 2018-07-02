<?php

/**

 *
 * Subattributes
 * =============
 * Typically, when a datatype does not contain a simple, scalar value
 * but differentiated data bits. So are the 'ezobjectrelation' and
 * 'ezobjectrelationlist' datatypes.
 * The 'ezimage' datatype is also in this case : it contains a binary file,
 * an alternative text for the image, and metadata for the image ( EXIF, IPTC, XMP, etc.),
 * all of which can be considered as "subattributes".
 * The default search-related handling of an ezimage attribute would be
 * to rely on the metaData() method of the datatype, returning the alternative
 * text entered, if any. An ezimage-specific handler, crafted after the example below
 * would allow using subattributes both when the attribute is being indexed,
 * and when it is being queried. This allows for instance to filter results on an
 * Image's EXIF metadata value.
 *
 *
 * Metadata preprocessing
 * ======================
 * An attribute's metadata may need to be processed prior to being sent
 * to the search engine. The 'ezxmltext' is an example : the formatted text
 * is stored as XML, of which textual data must be extracted. The
 * 'ezfSolrDocumentFieldXML' handler is responsible of this.
 *
 *
 */

class ezfSolrDocumentFieldOcEvent extends ezfSolrDocumentFieldBase
{
    const DEFAULT_SUBATTRIBUTE_TYPE = 'date_point';
    const FIELD_TYPE_MAP            = 'dp';

    function __construct( eZContentObjectAttribute $attribute )
    {
        parent::__construct( $attribute );
    }

    /**
     * @see ezfSolrDocumentFieldBase::getFieldName()
     */
    public static function getFieldName( eZContentClassAttribute $classAttribute, $subAttribute = null, $context = 'search' )
    {

        switch ( $classAttribute->attribute( 'data_type_string' ) ) {
            case 'ocevent':

                if ( $subAttribute and $subAttribute !== '' ) {
                    // A subattribute was passed
                    return parent::generateSubattributeFieldName( $classAttribute,
                        $subAttribute,
                        self::DEFAULT_SUBATTRIBUTE_TYPE );
                } else {
                    // return the default field name here.
                    return self::generateAttributeFieldName( $classAttribute,
                        self::getClassAttributeType( $classAttribute, null, $context ) );
                }
                break;

            default:
                break;
        }
    }


    public static function generateAttributeFieldName(eZContentClassAttribute $classAttribute, $type)
    {
        //return parent::generateAttributeFieldName($classAttribute, $type); // TODO: Change the autogenerated stub
        return parent::ATTR_FIELD_PREFIX . $classAttribute->attribute( 'identifier' ) . '____' . self::FIELD_TYPE_MAP;
    }


    /**
     * @see ezfSolrDocumentFieldBase::getData()
     */
    public function getData()
    {
        $data = array();
        $contentClassAttribute = $this->ContentObjectAttribute->attribute( 'contentclass_attribute' );
        $attributeFieldName = self::generateAttributeFieldName( $contentClassAttribute,  self::DEFAULT_SUBATTRIBUTE_TYPE);
        $metaData = json_decode( $this->ContentObjectAttribute->metaData(), true);

        $datePoints = array();
        //unset($metaData[0]);
        foreach ($metaData as $k => $v) {

            $start = $this->parseDate($v['start']);
            $end   = $this->parseDate($v['end']);

            if ( !is_null($start) && !is_null($end) ) {
                $datePoints []= (string) $start . ' ' . $end;
            }
            //break;

        }


      /*
      <field name="attr_event____dp">1530226800 1530234000</field>
      <field name="attr_event____dp">1530313200 1530320400</field>
      <field name="attr_event____dp">1530399600 1530406800</field>
      <field name="attr_event____dp">1530486000 1530493200</field>
      <field name="attr_event____dp">1530658800 1530666000</field>
      */

      //$data [$attributeFieldName] = $datePoints;
      //$data [$attributeFieldName] = array('1 1', '2 4', '2 5', '2 6', '2 7', time() . ' ' . time(), time() . ' ' . time(), time() . ' ' . time());
      $data [$attributeFieldName] = array('1530313200 1530320400');
        //$data [$attributeFieldName] = array('1530313200 1530320400');


        //$data [$attributeFieldName] = $datePoints;

        return $data;
    }

    /**
     * @param $inputDate
     * @param string $format
     * @return null|string
     * @throws Exception
     *
     * Il formato della data passata è 2017-10-20T10:37:06+02:00
     */
    public function parseDate( $inputDate, $format = DateTime::ISO8601 )
    {
        if ($inputDate == null) {
            return null;
        }

        $dateTime = DateTime::createFromFormat($format, $inputDate);
        if ($dateTime instanceOf DateTime) {
            return  $dateTime->format('U');
        }
        return null;
    }



}
?>
