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
            'get_min_bound',
            'get_max_bound'
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
        return array();
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
   * @return mixed
   */

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement )
    {
        $agenda = OpenPAAgenda::instance();
        switch( $operatorName )
        {
          case 'get_min_bound':
              return $operatorValue = OCRecurrenceHelper::MIN_BOUND;
              break;

          case 'get_max_bound':
            return $operatorValue = OCRecurrenceHelper::MAX_BOUND;
            break;
        }
    }
}
