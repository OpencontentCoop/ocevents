<?php

$module = $Params['Module'];
$tpl = eZTemplate::factory();

echo $tpl->fetch( 'design:recurrence/calendar.tpl' );
eZDisplayDebug();
eZExecution::cleanExit();
