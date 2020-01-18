<?php
require 'autoload.php';

$cli = eZCLI::instance();
$script = eZScript::instance(array(
    'description' => ("Convert object attributes in ocevent attribute\n\n"),
    'use-session' => false,
    'use-modules' => true,
    'use-extensions' => true
));

$script->startup();

$options = $script->getOptions('[class:][from:][to:][ocevent:]',
    '',
    array(
        'class' => 'Class identifier',
        'from_time' => 'From time attribute identifier',
        'to_time' => 'To time attribute identifier',
        'ocevent' => 'ocevent attribute identifier',
    )
);
$script->initialize();
$script->setUseDebugAccumulators(true);

try {
    if (isset($options['class'])) {
        $classIdentifier = $options['class'];
    } else {
        throw new Exception("Missing class argument");
    }

    $class = eZContentClass::fetchByIdentifier($classIdentifier);
    if (!$class instanceof eZContentClass) {
        throw new Exception("Class $classIdentifier not found");
    }

    if (isset($options['from_time'])) {
        $fromAttributeIdentifier = $options['from_time'];
    } else {
        throw new Exception("Missing from_time argument");
    }
    $fromAttribute = $class->fetchAttributeByIdentifier($fromAttributeIdentifier);
    if (!$fromAttribute instanceof eZContentClassAttribute) {
        throw new Exception("Attribute from_time $fromAttributeIdentifier not found in class $classIdentifier");
    }

    if (isset($options['to_time'])) {
        $toAttributeIdentifier = $options['to_time'];
    } else {
        throw new Exception("Missing to_time argument");
    }
    $toAttribute = $class->fetchAttributeByIdentifier($toAttributeIdentifier);
    if (!$toAttribute instanceof eZContentClassAttribute) {
        throw new Exception("Attribute to_time $toAttributeIdentifier not found in class $classIdentifier");
    }

    if (isset($options['ocevent'])) {
        $oceventAttributeIdentifier = $options['ocevent'];
    } else {
        throw new Exception("Missing to argument");
    }
    $oceventAttribute = $class->fetchAttributeByIdentifier($oceventAttributeIdentifier);
    if (!$oceventAttribute instanceof eZContentClassAttribute) {
        throw new Exception("Attribute ocevent $oceventAttributeIdentifier not found in class $classIdentifier");
    }

    $objects = $class->objectList();

    $cli->output("Done");


    $script->shutdown();
} catch (Exception $e) {
    $errCode = $e->getCode();
    $errCode = $errCode != 0 ? $errCode : 1; // If an error has occured, script must terminate with a status other than 0
    $script->shutdown($errCode, $e->getMessage());
}
