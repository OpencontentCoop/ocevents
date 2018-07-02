<?php

$module = $Params['Module'];
$tpl    = eZTemplate::factory();


$fetch_parameters = array(
  'query'     => '',
  //'class_id'  => array('codice_area'),
  'filter'    => array( 'attr_event_dp:"Intersects(0 7 8 365)"'),
  'limit'     => array(10)
);

$result = eZFunctionHandler::execute('ezfind', 'search', $fetch_parameters);


echo '<pre>';
print_r($result);
exit;
