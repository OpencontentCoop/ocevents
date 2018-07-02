<?php

$module = $Params['Module'];
$tpl = eZTemplate::factory();

echo $tpl->fetch( 'design:recurrence/demo.tpl' );
eZDisplayDebug();
eZExecution::cleanExit();