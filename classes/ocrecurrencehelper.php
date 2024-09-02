<?php


class OCRecurrenceHelper
{
    const FORMAT = 'Y-m-d\TH:i:sP';
    // DateTime::ISO8601

    const MIN_BOUND = '0';
    const MAX_BOUND = '2524607999';

    const DEFAULT_SUBATTRIBUTE_TYPE = 'date_point';
    const FIELD_TYPE_MAP = 'dp';

    private $phpHasBug = false;

    /**
     * @var array
     */
    protected $data = array(
        'startDateTime' => null,
        'endDateTime' => null,
        'recurrencePattern' => null,
        'exdate' => array(),
        'rdate' => array()
    );

    /**
     * @var DateTimeZone
     */
    protected $timezone;

    /**
     * @var string
     */
    protected $format = 'Y-m-d\TH:i:sP';

    /**
     * @var DateTime
     */
    protected $startDate;

    /**
     * @var DateTime
     */
    protected $endDate;

    /**
     * @var DateTime
     */
    protected $untilDate = false;

    /**
     * @var Recurr\Rule
     */
    protected $rule;

    /**
     * @var \Recurr\DateExclusion[]
     */
    protected $dateExclusions = array();

    private $isInit = false;

    public function __construct($input)
    {
        if (!is_array($input)) {
            $input = json_decode($input, true);
        }
        $this->setData($input);
    }

    public function setData($data)
    {
        $this->data = array_merge($this->data, $data);
        $this->isInit = false;
    }

    public function getData()
    {
        return $this->data;
    }

    protected function init()
    {
        if (!$this->isInit) {
            $timezoneOffset = $this->data['timeZone']['offset'];
            $timezone = preg_replace('/[^0-9]/', '', $timezoneOffset) * 36;
            $this->timezone = new DateTimeZone(timezone_name_from_abbr("", $timezone, 0));

            $this->data['startDateTime'] = $this->phpDateTimeBugWorkAround($this->data['startDateTime']);
            $this->data['endDateTime'] = $this->phpDateTimeBugWorkAround($this->data['endDateTime']);

            $this->startDate = DateTime::createFromFormat(
                $this->format,
                $this->data['startDateTime'],
                $this->timezone
            );

            if (!$this->startDate instanceof DateTime) {
                throw new InvalidArgumentException("Bad date format {$this->data['startDateTime']} ({$this->format})");
            }

            if ($this->data['endDateTime']) {
                $this->endDate = DateTime::createFromFormat(
                    $this->format,
                    $this->data['endDateTime'],
                    $this->timezone
                );
                if (!$this->endDate){
                    $this->endDate = DateTime::createFromFormat('U', strtotime($this->data['endDateTime']));
                }

                if ($this->endDate <= $this->startDate) {
                    throw new Exception("Invalid end date", 100);
                }
            }

            if ($this->data['until']) {
                $this->untilDate = DateTime::createFromFormat(
                    $this->format,
                    $this->data['until'],
                    $this->timezone
                );
            }

            $this->rule = new Recurr\Rule($this->data['recurrencePattern'], $this->startDate, $this->endDate);

            // Aggiungo l'unitl date alle ricorrenze
            /*if ($this->untilDate)  {
              $this->rule->setRDates(array($this->untilDate->format(DateTime::RFC3339)));
            }*/

            if (isset($this->data['exdate'])) {
                $exDates = is_string($this->data['exdate']) ? explode(',', $this->data['exdate']) : $this->data['exdate'];
                if (!empty($exDates)) {
                    $this->rule->setExDates($exDates);
                }
            }
            $this->isInit = true;
        }
    }

    /**
     * @see https://bugs.php.net/bug.php?id=45528
     * @param string $dateString
     *
     * @return string
     */
    private function phpDateTimeBugWorkAround($dateString)
    {
//        if (!DateTime::createFromFormat($this->format, $this->data['startDateTime'], $this->timezone) instanceof DateTime){
            $timezoneOffset = $this->data['timeZone']['offset'];
            if ($this->data['timeZone']['offset'] == '+00:00') {
                $timezoneOffset = 'Z';
            }
            $parts = explode($timezoneOffset, $dateString);
            $dateString = $parts[0];
            $this->format = 'Y-m-d\TH:i:s';
//            $this->phpHasBug = true;
//        }
        return $dateString;
    }

    public function getText()
    {
        $this->init();
        $text = '';
        $locale = explode('-', eZLocale::instance()->httpLocaleCode());
        $localeIdForTranslator = substr(strtolower($locale[0]), 0, 2);
        try {
            $translator = new \Recurr\Transformer\Translator($localeIdForTranslator);
        } catch (InvalidArgumentException $e) {
            eZDebug::writeError($e->getMessage(), __METHOD__);
            $translator = new \Recurr\Transformer\Translator('en');
        }
        $transformer = new \Recurr\Transformer\TextTransformer($translator);

        $text .= $transformer->transform($this->rule);
        if (isset($this->data['rdate'])) {

        }
        return $text;
    }

    public function getRecurrences()
    {
        $this->init();
        $recurrences = array();

        if (isset($this->data['rdate'])) {

        }

        $transformer = new \Recurr\Transformer\ArrayTransformer();
        /** @var \Recurr\Recurrence[] $collection */
        $collection = $transformer->transform($this->rule);
        foreach ($collection as $item) {
            $recurrences[] = array(
                'startDateTime' => $item->getStart(),
                'startTimestamp' => $item->getStart()->format('U'),
                'startHuman' => $item->getStart()->format(DateTime::RFC850),
                'endDateTime' => $item->getEnd(),
                'endTimestamp' => $item->getEnd()->format('U'),
                'endHuman' => $item->getEnd()->format(DateTime::RFC850)
            );
        }
        return $recurrences;
    }

    public function getFullCalendarRecurrences()
    {
        $this->init();
        $recurrences = array();
        $transformer = new \Recurr\Transformer\ArrayTransformer();
        /** @var \Recurr\Recurrence[] $collection */
        $collection = $transformer->transform($this->rule);
        foreach ($collection as $item) {
            $recurrences[] = array(
                'id' => $item->getStart()->format('U') . '-' . $item->getEnd()->format('U'),
                'start' => $item->getStart()->format(DateTime::RFC3339),
                'end' => $item->getEnd()->format(DateTime::RFC3339)
            );
        }
        return $recurrences;
    }

    public static function addSolrFieldTypeMap()
    {
        if (!isset(ezfSolrDocumentFieldName::$FieldTypeMap[self::DEFAULT_SUBATTRIBUTE_TYPE])) {
            ezfSolrDocumentFieldName::$FieldTypeMap[self::DEFAULT_SUBATTRIBUTE_TYPE] = self::FIELD_TYPE_MAP;
        }
    }

}
