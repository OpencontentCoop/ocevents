<?php

use Opencontent\Opendata\Api\AttributeConverter\Base;
use Opencontent\Opendata\Api\PublicationProcess;
use Opencontent\Opendata\Api\Exception\InvalidInputException;

class OCEventOpendataConverter extends Base
{
    public function get(eZContentObjectAttribute $attribute)
    {
        $content = parent::get($attribute);

        $data = $attribute->hasContent() ? json_decode($attribute->attribute('data_text'), true) : null;
        if (!is_null($data)) {
            $data['default_value'] = array(
                'count' => count($data['events']),
                'from_time' => $data['events'][0]['start'],
                'to_time' => $data['events'][0]['end']
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

    public function type(eZContentClassAttribute $attribute)
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
