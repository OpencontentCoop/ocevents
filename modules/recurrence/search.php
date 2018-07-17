<?php

$module = $Params['Module'];
$tpl    = eZTemplate::factory();





$input = '{"startDateTime":"2018-07-17T08:00:00+02:00","endDateTime":"2018-07-17T12:00:00+02:00","freq":"2","interval":"1","until":"2020-07-13T00:00:00+02:00","byweekday":["1","2"],"timeZone":{"name":"W. Europe Standard Time","offset":"+01:00"},"recurrencePattern":"DTSTART=20180717T060000Z;FREQ=WEEKLY;INTERVAL=1;UNTIL=20200712T220000Z;BYDAY=TU,WE"}';
$helper = new OCRecurrenceHelper( $input );
$data = array(
  'recurrences' => $helper->getFullCalendarRecurrences(),
  'text' => $helper->getText(),
);

echo '<pre>';
print_r(json_decode($input, true));
print_r($data);
exit;


/*


Index (Multiple) Durrations As (Multiple) Points
    X = "Start"
    Y = "End"
Query Using Rectangles Defined in Various Ways
    Document Durration Contains Query Durration --> Il periodo dell'evento contiene il periodo della query
    q=fieldX:"Intersects(-∞ end start ∞)"

    Document Durration Overlaps Query Durration --> Il periodo dell'evento si sovrappone al periodo query
    q=fieldX:"Intersects(-∞ start end ∞)"

    Document Durration Within Query Durration   --> Il periodo della query contiene il periodo dell'evento
    q=fieldX:"Intersects(start -∞ ∞ end)"

*/

$min   = '0';
$start = strtotime('2018-07-12 00:00:00');
$stop  = strtotime('2018-07-14 23:59:59');
$max   = '2524607999';

// The winner is overlaps

// Overlaps
$filter = 'attr_event_dp:"Intersects('.$min.' '.$start.' '.$stop.' '.$max.')"';

// Whithin
//$filter = 'attr_event_dp:"Intersects('.$start.' '.$min.' '.$max.' '.$stop.')"';

//$filter = 'attr_event_dp:"Intersects(1 300 1000 350)"';


$fetch_parameters = array(
  'query'     => '',
  //'class_id'  => array('codice_area'),
  'filter'    => array( $filter ),
  'limit'     => array(10)
);

$result = eZFunctionHandler::execute('ezfind', 'search', $fetch_parameters);


echo '<pre>';
print_r($result);
exit;
