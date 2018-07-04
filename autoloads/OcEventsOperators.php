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
          'recurrences_min_bound',
          'recurrences_max_bound',
          'recurrences_solr_field_name'
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
          case 'recurrences_min_bound':
              return $operatorValue = OCRecurrenceHelper::MIN_BOUND;
              break;

          case 'recurrences_max_bound':
            return $operatorValue = OCRecurrenceHelper::MAX_BOUND;
            break;

          case 'recurrences_solr_field_name':
            return $operatorValue = OCRecurrenceHelper::SOLR_FIELD_NAME;
            break;
        }
    }
}
