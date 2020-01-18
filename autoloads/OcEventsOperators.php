<?php

class OcEventsOperators
{
    /**
     * Returns the list of template operators this class supports
     *
     * @return array
     */
    function operatorList()
    {
        return array(
            'recurrences_strtotime',
            'recurrences_next_events'
        );
    }

    /**
     * Indicates if the template operators have named parameters
     *
     * @return bool
     */
    function namedParameterPerOperator()
    {
        return true;
    }

    /**
     * Returns the list of template operator parameters
     *
     * @return array
     */
    function namedParameterList()
    {
        return array(
            'recurrences_strtotime' => array(
                'time_string' => array('type' => 'string', 'required' => true, 'default' => '')
            ),
            'recurrences_next_events' => array(
                'events' => array('type' => 'array', 'required' => true, 'default' => array()),
                'limit' => array('type' => 'string', 'required' => false, 'default' => 5),
            )
        );
    }

    /**
     * @param $tpl
     * @param $operatorName
     * @param $operatorParameters
     * @param $rootNamespace
     * @param $currentNamespace
     * @param $operatorValue
     * @param $namedParameters
     * @param $placement
     */

    function modify($tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement)
    {
        switch ($operatorName) {
            case 'recurrences_strtotime':
                $operatorValue = strtotime($namedParameters['time_string']);
                break;

            case 'recurrences_next_events':
                $operatorValue = array();
                $events = $namedParameters['events'];
                $limit = (int)$namedParameters['limit'];
                $now = time();
                foreach ($events as $event) {
                    $start = strtotime($event['start']);
                    if ($start > $now && $limit) {
                        $operatorValue[] = $event;
                        if (count($operatorValue) == $limit) {
                            break;
                        }
                    }
                }
                break;
        }
    }
}
