<?php

$module = $Params['Module'];

$data = array();
try {
    header('HTTP/1.1 200 OK');
    $helper = new OCRecurrenceHelper($_POST);
    $data = array(
        'recurrences' => $helper->getFullCalendarRecurrences(),
        'text' => $helper->getText(),
        'input' => $helper->getData(),
    );
} catch (Exception $e) {
    header('HTTP/1.1 400 Bad Request');
    $data = array(
        'error' => $e->getMessage(),
        'code' => $e->getCode(),
//        'trace' => $e->getTrace()
    );
}

header('Content-Type: application/json');
echo json_encode($data);
eZExecution::cleanExit();
