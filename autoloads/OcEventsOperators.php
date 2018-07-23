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
            'recurrences_strtotime'
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
        $agenda = OpenPAAgenda::instance();
        switch ($operatorName) {
            case 'recurrences_strtotime':
                $operatorValue = strtotime($namedParameters['time_string']);
                break;
        }
    }
}
