<?php

/**
 * Class OcEventsFullCalendarEvent
 * @see https://fullcalendar.io/docs/event_data/Event_Object/
 */
class OcEventsFullCalendarEvent implements JsonSerializable
{
    private $content;

    private $id;

    private $title;

    private $allDay;

    private $start;

    private $end;

    private $url;

    private $className;

    private $editable;

    private $startEditable;

    private $durationEditable;

    private $resourceEditable;

    private $rendering;

    private $overlap;

    private $constraint;

    private $color;

    private $backgroundColor;

    private $borderColor;

    private $textColor;

    /**
     * @param mixed $content
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setContent($content)
    {
        $this->content = $content;

        return $this;
    }

    /**
     * @param mixed $id
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * @param mixed $title
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setTitle($title)
    {
        $this->title = $title;

        return $this;
    }

    /**
     * @param mixed $allDay
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setAllDay($allDay)
    {
        $this->allDay = $allDay;

        return $this;
    }

    /**
     * @param mixed $start
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setStart($start)
    {
        $this->start = $start;

        return $this;
    }

    /**
     * @param mixed $end
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setEnd($end)
    {
        $this->end = $end;

        return $this;
    }

    /**
     * @param mixed $url
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setUrl($url)
    {
        $this->url = $url;

        return $this;
    }

    /**
     * @param mixed $className
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setClassName($className)
    {
        $this->className = $className;

        return $this;
    }

    /**
     * @param mixed $editable
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setEditable($editable)
    {
        $this->editable = $editable;

        return $this;
    }

    /**
     * @param mixed $startEditable
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setStartEditable($startEditable)
    {
        $this->startEditable = $startEditable;

        return $this;
    }

    /**
     * @param mixed $durationEditable
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setDurationEditable($durationEditable)
    {
        $this->durationEditable = $durationEditable;

        return $this;
    }

    /**
     * @param mixed $resourceEditable
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setResourceEditable($resourceEditable)
    {
        $this->resourceEditable = $resourceEditable;

        return $this;
    }

    /**
     * @param mixed $rendering
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setRendering($rendering)
    {
        $this->rendering = $rendering;

        return $this;
    }

    /**
     * @param mixed $overlap
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setOverlap($overlap)
    {
        $this->overlap = $overlap;

        return $this;
    }

    /**
     * @param mixed $constraint
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setConstraint($constraint)
    {
        $this->constraint = $constraint;

        return $this;
    }

    /**
     * @param mixed $color
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setColor($color)
    {
        $this->color = $color;

        return $this;
    }

    /**
     * @param mixed $backgroundColor
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setBackgroundColor($backgroundColor)
    {
        $this->backgroundColor = $backgroundColor;

        return $this;
    }

    /**
     * @param mixed $borderColor
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setBorderColor($borderColor)
    {
        $this->borderColor = $borderColor;

        return $this;
    }

    /**
     * @param mixed $textColor
     *
     * @return OcEventsFullCalendarEvent
     */
    public function setTextColor($textColor)
    {
        $this->textColor = $textColor;

        return $this;
    }

    function jsonSerialize()
    {
        $data = array();
        try {
            $reflection = new ReflectionClass($this);
            foreach ($reflection->getProperties() as $property) {
                $name = $property->getName();
                $value = $this->{$name};
                if ($value !== null) {
                    $data[$name] = $value;
                }
            }
        } catch (Exception $e) {

        }

        return $data;
    }
}
