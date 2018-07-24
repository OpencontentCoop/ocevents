<?php

use Opencontent\Opendata\Api\AttributeConverter\Base;
use Opencontent\Opendata\Api\PublicationProcess;
use Opencontent\Opendata\Api\Exception\InvalidInputException;

class OCEventOpendataConverter extends Base
{
    public function get(eZContentObjectAttribute $attribute)
    {
        $content = array(
            'id' => intval( $attribute->attribute( 'id' ) ),
            'version' => intval( $attribute->attribute( 'version' ) ),
            'identifier' => $this->classIdentifier . '/' . $this->identifier,
            'datatype' => $attribute->attribute( 'data_type_string' ),
            'content' => null
        );

        $data = $attribute->hasContent() ? json_decode( $attribute->toString(), true) : null;
        if ( !is_null($data) ) {
          $data['default_value']     = array(
            'count'     => count($data['events']),
            'from_time' => $data['events'][0]['start'],
            'to_time'   => $data['events'][0]['end']
          );
        }
        $content['content'] = $data;
        return $content;
    }

    public function set($data, PublicationProcess $process)
    {
        return $data;
    }

    /**
     * @param $identifier
     * @param $data
     * @param eZContentClassAttribute $attribute
     * @throws InvalidInputException
     */
    public static function validate($identifier, $data, eZContentClassAttribute $attribute)
    {
      if ($data !== null && $data !== false && !is_string($data)) {
        throw new InvalidInputException('Invalid type', $identifier, $data);
      }
    }

    public function type( eZContentClassAttribute $attribute )
    {
        return array(
            'identifier' => 'ocevent',
            'format' => array(
                array(
                    'input' => 'Input Ical Format',
                    'text' => 'Parsed input to text',
                    'recurrences' => 'json',
                    'events' => 'json'
                )
            )
        );
    }
}
