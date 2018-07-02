<?php

$module = $Params['Module'];

$data = array();
try
{
    header( 'HTTP/1.1 200 OK' );
    $helper = new OCRecurrenceHelper( $_POST );
    $data = array(
        'recurrences' => $helper->getFullCalendarRecurrences(),
        'text' => $helper->getText(),
    );
}
catch ( Exception $e )
{
    header( 'HTTP/1.1 500 Internal Server Error' );
    $data = array( 'error' => $e->getMessage(), 'trace' => $e->getTrace() );
}

header('Content-Type: application/json');
echo json_encode( $data );
eZExecution::cleanExit();