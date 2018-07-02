{ezcss_require(array('fuelux.min.css', 'fullcalendar.min.css'))}
<style>
    {literal}
    .fuelux .scheduler .end-datetime.form-group {
        margin-bottom: 0;
    }

    .fuelux .scheduler .end-datetime .form-group {
        margin-left: 0;
    }

    .fuelux .datepicker-calendar-wrapper {
        width: auto;
    }

    .fuelux .scheduler .start-datetime .combobox {
        max-width: none;
    }

    .modal {
        margin-top: 200px;
    }

    {/literal}
</style>

<div class="row fuelux">
    <div class="col-md-12">
        <div class="form-horizontal scheduler" data-initialize="fullscheduler" role="form" id="myScheduler">
            <div class="row form-group start-datetime">
                <label class="col-sm-12 scheduler-label" for="myStartDate">Inizio</label>
                <div class="col-sm-9 form-group">
                    <div class="datepicker start-date">
                        <div class="input-group">
                            <input class="form-control" id="myStartDate" type="text"/>
                            {include uri='design:recurrence/parts/datepicker.tpl'}
                        </div>
                    </div>
                </div>

                <div class="col-sm-3 form-group">
                    <label class="sr-only" for="MyStartTime">Start Time</label>
                    <div class="input-group combobox start-time">
                        <input id="myStartTime" type="text" class="form-control"/>
                        {include uri='design:recurrence/parts/timepicker.tpl'}
                    </div>
                </div>
            </div>

            <div class="row form-group end-datetime">
                <label class="col-sm-12 scheduler-label" for="myStartDate">Fine</label>
                <div class="col-sm-9 form-group">
                    <div class="datepicker end-date">
                        <div class="input-group">
                            <input class="form-control" id="myEndDate" type="text"/>
                            {include uri='design:recurrence/parts/datepicker.tpl'}
                        </div>
                    </div>
                </div>

                <div class="col-sm-3 form-group">
                    <label class="sr-only" for="MyEndTime">End Time</label>
                    <div class="input-group combobox end-time">
                        <input id="myEndTime" type="text" class="form-control"/>
                        {include uri='design:recurrence/parts/timepicker.tpl'}
                    </div>
                </div>
            </div>

            <div class="row form-group timezone-container hide">
                <label class="col-sm-2 control-label scheduler-label">Timezone</label>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <div data-resize="auto" class="btn-group selectlist timezone">
                        <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                            <span class="selected-label">(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna *</span>
                            <span class="caret"></span>
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li data-name="W. Europe Standard Time" data-offset="+01:00"><a href="#">(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna *</a></li>
                        </ul>
                        <input type="text" aria-hidden="true" readonly="readonly" name="TimeZoneSelectlist" class="hidden hidden-field">
                    </div>
                </div>
            </div>

            <div class="form-group repeat-container">
                <label class="col-sm-12 scheduler-label">Ripetizioni</label>

                <div class="col-sm-10">
                    <div class="form-group repeat-interval">
                        <div data-resize="auto"
                             class="btn-group selectlist pull-left repeat-options">
                            <button data-toggle="dropdown"
                                    class="btn btn-default dropdown-toggle"
                                    type="button">
                                <span class="selected-label">None (run once)</span>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li data-value="none"><a href="#">None (run once)</a></li>
                                <li data-value="hourly" data-text="hour(s)"><a
                                            href="#">Hourly</a></li>
                                <li data-value="daily" data-text="day(s)"><a href="#">Daily</a>
                                </li>
                                <li data-value="weekdays"><a href="#">Weekdays</a></li>
                                <li data-value="weekly" data-text="week(s)"><a
                                            href="#">Weekly</a></li>
                                <li data-value="monthly" data-text="month(s)"><a href="#">Monthly</a>
                                </li>
                                <li data-value="yearly"><a href="#">Yearly</a></li>
                            </ul>
                            <input type="text" aria-hidden="true" readonly="readonly"
                                   name="intervalSelectlist" class="hidden hidden-field">
                        </div>

                        <div class="repeat-panel repeat-every-panel repeat-hourly repeat-daily repeat-weekly hide"
                             aria-hidden="true">
                            <label id="MySchedulerEveryLabel"
                                   class="inline-form-text repeat-every-pretext">every</label>

                            <div class="spinbox digits-3 repeat-every">
                                <input type="text" class="form-control input-mini spinbox-input"
                                       aria-labelledby="MySchedulerEveryLabel">

                                <div class="spinbox-buttons btn-group btn-group-vertical">
                                    <button type="button"
                                            class="btn btn-default spinbox-up btn-xs">
                                        <span class="glyphicon glyphicon-chevron-up"></span><span
                                                class="sr-only">Increase</span>
                                    </button>
                                    <button type="button"
                                            class="btn btn-default spinbox-down btn-xs">
                                        <span class="glyphicon glyphicon-chevron-down"></span><span
                                                class="sr-only">Decrease</span>
                                    </button>
                                </div>
                            </div>

                            <div class="inline-form-text repeat-every-text"></div>
                        </div>
                    </div>

                    <div class="form-group repeat-panel repeat-weekly repeat-days-of-the-week hide"
                         aria-hidden="true">
                        <fieldset class="btn-group" data-toggle="buttons">
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="SU">Sun
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="MO">Mon
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="TU">Tue
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="WE"> Wed
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="TH"> Thu
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="FR"> Fri
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="SA"> Sat
                            </label>
                        </fieldset>
                    </div>


                    <div class="repeat-panel repeat-monthly hide" aria-hidden="true">
                        <div class="form-group repeat-monthly-date">
                            <div class="radio pull-left">
                                <label class="radio-custom">
                                    <input class="sr-only" type="radio" checked="checked"
                                           name="repeat-monthly" value="bymonthday">
                                    <span class="radio-label">on day</span>
                                </label>
                            </div>

                            <div data-resize="auto" class="btn-group selectlist pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">1</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu"
                                    style="height:200px; overflow:auto;">
                                    <li data-value="1"><a href="#">1</a></li>
                                    <li data-value="2"><a href="#">2</a></li>
                                    <li data-value="3"><a href="#">3</a></li>
                                    <li data-value="4"><a href="#">4</a></li>
                                    <li data-value="5"><a href="#">5</a></li>
                                    <li data-value="6"><a href="#">6</a></li>
                                    <li data-value="7"><a href="#">7</a></li>
                                    <li data-value="8"><a href="#">8</a></li>
                                    <li data-value="9"><a href="#">9</a></li>
                                    <li data-value="10"><a href="#">10</a></li>
                                    <li data-value="11"><a href="#">11</a></li>
                                    <li data-value="12"><a href="#">12</a></li>
                                    <li data-value="13"><a href="#">13</a></li>
                                    <li data-value="14"><a href="#">14</a></li>
                                    <li data-value="15"><a href="#">15</a></li>
                                    <li data-value="16"><a href="#">16</a></li>
                                    <li data-value="17"><a href="#">17</a></li>
                                    <li data-value="18"><a href="#">18</a></li>
                                    <li data-value="19"><a href="#">19</a></li>
                                    <li data-value="20"><a href="#">20</a></li>
                                    <li data-value="21"><a href="#">21</a></li>
                                    <li data-value="22"><a href="#">22</a></li>
                                    <li data-value="23"><a href="#">23</a></li>
                                    <li data-value="24"><a href="#">24</a></li>
                                    <li data-value="25"><a href="#">25</a></li>
                                    <li data-value="26"><a href="#">26</a></li>
                                    <li data-value="27"><a href="#">27</a></li>
                                    <li data-value="28"><a href="#">28</a></li>
                                    <li data-value="29"><a href="#">29</a></li>
                                    <li data-value="30"><a href="#">30</a></li>
                                    <li data-value="31"><a href="#">31</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly"
                                       name="monthlySelectlist" class="hidden hidden-field">
                            </div>
                        </div>

                        <div class="repeat-monthly-day form-group">
                            <div class="radio pull-left">
                                <label class="radio-custom">
                                    <input class="sr-only" type="radio" checked="checked"
                                           name="repeat-monthly" value="bysetpos">
                                    <span class="radio-label">on the</span>
                                </label>
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist month-day-pos pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">First</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li data-value="1"><a href="#">First</a></li>
                                    <li data-value="2"><a href="#">Second</a></li>
                                    <li data-value="3"><a href="#">Third</a></li>
                                    <li data-value="4"><a href="#">Fourth</a></li>
                                    <li data-value="-1"><a href="#">Last</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly"
                                       name="monthlySelectlist" class="hidden hidden-field">
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist month-days pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">Sunday</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li data-value="SU"><a href="#">Sunday</a></li>
                                    <li data-value="MO"><a href="#">Monday</a></li>
                                    <li data-value="TU"><a href="#">Tuesday</a></li>
                                    <li data-value="WE"><a href="#">Wednesday</a></li>
                                    <li data-value="TH"><a href="#">Thursday</a></li>
                                    <li data-value="FR"><a href="#">Friday</a></li>
                                    <li data-value="SA"><a href="#">Saturday</a></li>
                                    <li data-value="SU,MO,TU,WE,TH,FR,SA"><a href="#">Day</a>
                                    </li>
                                    <li data-value="MO,TU,WE,TH,FR"><a href="#">Weekday</a></li>
                                    <li data-value="SU,SA"><a href="#">Weekend day</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly"
                                       name="monthlySelectlist" class="hidden hidden-field">
                            </div>

                        </div>
                    </div>

                    <div class="repeat-panel repeat-yearly hide" aria-hidden="true">

                        <div class="form-group repeat-yearly-date">

                            <div class="radio pull-left">
                                <label class="radio-custom">
                                    <input class="sr-only" type="radio" checked="checked"
                                           name="repeat-yearly" value="bymonthday">
                                    <span class="radio-label">on</span>
                                </label>
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">January</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li data-value="1"><a href="#">January</a></li>
                                    <li data-value="2"><a href="#">February</a></li>
                                    <li data-value="3"><a href="#">March</a></li>
                                    <li data-value="4"><a href="#">April</a></li>
                                    <li data-value="5"><a href="#">May</a></li>
                                    <li data-value="6"><a href="#">June</a></li>
                                    <li data-value="7"><a href="#">July</a></li>
                                    <li data-value="8"><a href="#">August</a></li>
                                    <li data-value="9"><a href="#">September</a></li>
                                    <li data-value="10"><a href="#">October</a></li>
                                    <li data-value="11"><a href="#">November</a></li>
                                    <li data-value="12"><a href="#">December</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly" name="monthlySelectlist" class="hidden hidden-field">
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month-day pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">1</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu"
                                    style="height:200px; overflow:auto;">
                                    <li data-value="1"><a href="#">1</a></li>
                                    <li data-value="2"><a href="#">2</a></li>
                                    <li data-value="3"><a href="#">3</a></li>
                                    <li data-value="4"><a href="#">4</a></li>
                                    <li data-value="5"><a href="#">5</a></li>
                                    <li data-value="6"><a href="#">6</a></li>
                                    <li data-value="7"><a href="#">7</a></li>
                                    <li data-value="8"><a href="#">8</a></li>
                                    <li data-value="9"><a href="#">9</a></li>
                                    <li data-value="10"><a href="#">10</a></li>
                                    <li data-value="11"><a href="#">11</a></li>
                                    <li data-value="12"><a href="#">12</a></li>
                                    <li data-value="13"><a href="#">13</a></li>
                                    <li data-value="14"><a href="#">14</a></li>
                                    <li data-value="15"><a href="#">15</a></li>
                                    <li data-value="16"><a href="#">16</a></li>
                                    <li data-value="17"><a href="#">17</a></li>
                                    <li data-value="18"><a href="#">18</a></li>
                                    <li data-value="19"><a href="#">19</a></li>
                                    <li data-value="20"><a href="#">20</a></li>
                                    <li data-value="21"><a href="#">21</a></li>
                                    <li data-value="22"><a href="#">22</a></li>
                                    <li data-value="23"><a href="#">23</a></li>
                                    <li data-value="24"><a href="#">24</a></li>
                                    <li data-value="25"><a href="#">25</a></li>
                                    <li data-value="26"><a href="#">26</a></li>
                                    <li data-value="27"><a href="#">27</a></li>
                                    <li data-value="28"><a href="#">28</a></li>
                                    <li data-value="29"><a href="#">29</a></li>
                                    <li data-value="30"><a href="#">30</a></li>
                                    <li data-value="31"><a href="#">31</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly" name="monthlySelectlist" class="hidden hidden-field">
                            </div>
                        </div>

                        <div class="form-group repeat-yearly-day">

                            <div class="radio pull-left"><label class="radio-custom"><input
                                            class="sr-only"
                                            type="radio"
                                            name="repeat-yearly"
                                            value="bysetpos">
                                    on the</label></div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month-day-pos pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">First</span>
                                    <span class="caret"></span>
                                    <span class="sr-only">First</span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li data-value="1"><a href="#">First</a></li>
                                    <li data-value="2"><a href="#">Second</a></li>
                                    <li data-value="3"><a href="#">Third</a></li>
                                    <li data-value="4"><a href="#">Fourth</a></li>
                                    <li data-value="-1"><a href="#">Last</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly"
                                       name="yearlyDateSelectlist" class="hidden hidden-field">
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month-days pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">Sunday</span>
                                    <span class="caret"></span>
                                    <span class="sr-only">Sunday</span>
                                </button>
                                <ul class="dropdown-menu" role="menu"
                                    style="height:200px; overflow:auto;">
                                    <li data-value="SU"><a href="#">Sunday</a></li>
                                    <li data-value="MO"><a href="#">Monday</a></li>
                                    <li data-value="TU"><a href="#">Tuesday</a></li>
                                    <li data-value="WE"><a href="#">Wednesday</a></li>
                                    <li data-value="TH"><a href="#">Thursday</a></li>
                                    <li data-value="FR"><a href="#">Friday</a></li>
                                    <li data-value="SA"><a href="#">Saturday</a></li>
                                    <li data-value="SU,MO,TU,WE,TH,FR,SA"><a href="#">Day</a>
                                    </li>
                                    <li data-value="MO,TU,WE,TH,FR"><a href="#">Weekday</a></li>
                                    <li data-value="SU,SA"><a href="#">Weekend day</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly"
                                       name="yearlyDaySelectlist" class="hidden hidden-field">
                            </div>
                            <div class="inline-form-text repeat-yearly-day-text"> of</div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month pull-left">
                                <button data-toggle="dropdown"
                                        class="btn btn-default dropdown-toggle"
                                        type="button">
                                    <span class="selected-label">January</span>
                                    <span class="caret"></span>
                                    <span class="sr-only">January</span>
                                </button>
                                <ul class="dropdown-menu" role="menu"
                                    style="height:200px; overflow:auto;">
                                    <li data-value="1"><a href="#">January</a></li>
                                    <li data-value="2"><a href="#">February</a></li>
                                    <li data-value="3"><a href="#">March</a></li>
                                    <li data-value="4"><a href="#">April</a></li>
                                    <li data-value="5"><a href="#">May</a></li>
                                    <li data-value="6"><a href="#">June</a></li>
                                    <li data-value="7"><a href="#">July</a></li>
                                    <li data-value="8"><a href="#">August</a></li>
                                    <li data-value="9"><a href="#">September</a></li>
                                    <li data-value="10"><a href="#">October</a></li>
                                    <li data-value="11"><a href="#">November</a></li>
                                    <li data-value="12"><a href="#">December</a></li>
                                </ul>
                                <input type="text" aria-hidden="true" readonly="readonly" name="yearlyDaySelectlist" class="hidden hidden-field">
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="form-group repeat-end hide" aria-hidden="true">
                <label class="col-sm-12 scheduler-label">End</label>

                <div class="col-sm-12 row">
                    <div class="col-sm-4 form-group">
                        <div data-resize="auto"
                             class="btn-group selectlist end-options pull-left">
                            <button data-toggle="dropdown"
                                    class="btn btn-default dropdown-toggle"
                                    type="button">
                                <span class="selected-label">Never</span>
                                <span class="caret"></span>
                                <span class="sr-only">Never</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li data-value="never"><a href="#">Never</a></li>
                                <li data-value="after"><a href="#">After</a></li>
                                <li data-value="date"><a href="#">On date</a></li>
                            </ul>
                            <input type="text" aria-hidden="true" readonly="readonly"
                                   name="EndSelectlist"
                                   class="hidden hidden-field">
                        </div>
                    </div>

                    <div class="col-sm-6 form-group end-option-panel end-after-panel pull-left hide"
                         aria-hidden="true">
                        <div class="spinbox digits-3 end-after">
                            <label id="MyEndAfter" class="sr-only">End After</label>
                            <input type="text" class="form-control input-mini spinbox-input"
                                   aria-labelledby="MyEndAfter">

                            <div class="spinbox-buttons btn-group btn-group-vertical">
                                <button type="button" class="btn btn-default spinbox-up btn-xs">
                                    <span class="glyphicon glyphicon-chevron-up"></span><span
                                            class="sr-only">Increase</span>
                                </button>
                                <button type="button"
                                        class="btn btn-default spinbox-down btn-xs">
                                    <span class="glyphicon glyphicon-chevron-down"></span><span
                                            class="sr-only">Decrease</span>
                                </button>
                            </div>
                        </div>
                        <div class="inline-form-text end-after-text">occurance(s)</div>
                    </div>

                    <div class="col-sm-8 form-group end-option-panel end-on-date-panel pull-left hide"
                         aria-hidden="true">
                        <div class="datepicker input-group end-on-date">
                            <div class="input-group">
                                <input class="form-control" type="text"/>

                                <div class="input-group-btn">
                                    <button type="button"
                                            class="btn btn-default dropdown-toggle"
                                            data-toggle="dropdown">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                        <span class="sr-only">Toggle Calendar</span>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-right datepicker-calendar-wrapper"
                                         role="menu">
                                        <div class="datepicker-calendar">
                                            <div class="datepicker-calendar-header">
                                                <button class="prev"><span
                                                            class="glyphicon glyphicon-chevron-left"></span><span
                                                            class="sr-only">Previous Month</span>
                                                </button>
                                                <button class="next"><span
                                                            class="glyphicon glyphicon-chevron-right"></span><span
                                                            class="sr-only">Next Month</span>
                                                </button>
                                                <button class="title">
                                                    <span class="month">
                                                    <span data-month="0">January</span>
                                                    <span data-month="1">February</span>
                                                    <span data-month="2">March</span>
                                                    <span data-month="3">April</span>
                                                    <span data-month="4">May</span>
                                                    <span data-month="5">June</span>
                                                    <span data-month="6">July</span>
                                                    <span data-month="7">August</span>
                                                    <span data-month="8">September</span>
                                                    <span data-month="9">October</span>
                                                    <span data-month="10">November</span>
                                                    <span data-month="11">December</span>
                                                    </span> <span class="year"></span>
                                                </button>
                                            </div>
                                            <table class="datepicker-calendar-days">
                                                <thead>
                                                <tr>
                                                    <th>Su</th>
                                                    <th>Mo</th>
                                                    <th>Tu</th>
                                                    <th>We</th>
                                                    <th>Th</th>
                                                    <th>Fr</th>
                                                    <th>Sa</th>
                                                </tr>
                                                </thead>
                                                <tbody></tbody>
                                            </table>
                                            <div class="datepicker-calendar-footer">
                                                <button class="datepicker-today">Today</button>
                                            </div>
                                        </div>
                                        <div class="datepicker-wheels" aria-hidden="true">
                                            <div class="datepicker-wheels-month">
                                                <h2 class="header">Month</h2>
                                                <ul>
                                                    <li data-month="0">
                                                        <button>Jan</button>
                                                    </li>
                                                    <li data-month="1">
                                                        <button>Feb</button>
                                                    </li>
                                                    <li data-month="2">
                                                        <button>Mar</button>
                                                    </li>
                                                    <li data-month="3">
                                                        <button>Apr</button>
                                                    </li>
                                                    <li data-month="4">
                                                        <button>May</button>
                                                    </li>
                                                    <li data-month="5">
                                                        <button>Jun</button>
                                                    </li>
                                                    <li data-month="6">
                                                        <button>Jul</button>
                                                    </li>
                                                    <li data-month="7">
                                                        <button>Aug</button>
                                                    </li>
                                                    <li data-month="8">
                                                        <button>Sep</button>
                                                    </li>
                                                    <li data-month="9">
                                                        <button>Oct</button>
                                                    </li>
                                                    <li data-month="10">
                                                        <button>Nov</button>
                                                    </li>
                                                    <li data-month="11">
                                                        <button>Dec</button>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="datepicker-wheels-year">
                                                <h2 class="header">Year</h2>
                                                <ul></ul>
                                            </div>
                                            <div class="datepicker-wheels-footer clearfix">
                                                <button class="btn datepicker-wheels-back">
                                                    <span class="glyphicon glyphicon-arrow-left"></span>
                                                    <span class="sr-only">Return to Calendar</span>
                                                </button>
                                                <button type="button" class="btn datepicker-wheels-select">
                                                    Select <span class="sr-only">Month and Year</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row hide">
    <div class="col-md-12">
        <input type="hidden" id="has_content" value="{$attribute.has_content}">
        <h3>Text</h3>
        <textarea id="demoResult1" name="{$attribute_base}_ocevent_data_{$attribute.id}[text]" rows="1" cols="50" class="form-control">{if $content.text}{$content.text}{/if}</textarea>

        <h3>Input</h3>
        <textarea id="demoInput" name="{$attribute_base}_ocevent_data_{$attribute.id}[input]" rows="10" cols="50" class="form-control">{if $content.input_json}{$content.input_json}{/if}</textarea>

        <h3>Recurrences</h3>
        <textarea id="demoResult2" name="{$attribute_base}_ocevent_data_{$attribute.id}[recurrences]" rows="10" cols="50" class="form-control">{if $content.recurrences_json}{$content.recurrences_json}{/if}</textarea>

        <h3>Events</h3>
        <textarea id="events" name="{$attribute_base}_ocevent_data_{$attribute.id}[events]" rows="10" cols="50" class="form-control">{if $content.events_json}{$content.events_json}{/if}</textarea>
    </div>
</div>

<div class="row">
    <div class="col-sm-12">
        <h3>Calendario evento</h3>
        <hr />
        <div id='calendar'></div>
    </div>
</div>

<div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title">Modifica evento</h3>
            </div>
            <div class="modal-body">
                <input type="hidden" id="title" />
                <div class="form-group">
                    <label for="starts-at">Password</label>
                    <input type="text" class="form-control" name="starts_at" id="starts-at">
                </div>
                <div class="form-group">
                    <label for="ends-at">Password</label>
                    <input type="text" class="form-control" name="ends_at" id="ends-at">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-left" data-dismiss="modal" id="delete-event"><i class="fa fa-trash"></i> Elimina</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
                <button type="button" class="btn btn-success" data-dismiss="modal" id="save-event"><i class="fa fa-save"></i> Salva</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

{ezscript_require(array(
'ezjsc::jquery',
'bootstrap.min.js',
'moment-with-locales.min.js',
'fuelux.min.js',
'fullscheduler.js',
'fullcalendar/fullcalendar.min.js',
'fullcalendar/locale/it.js',
'bootstrap-datetimepicker.min.js'))}

<script>
    {literal}
    $(document).ready(function () {

      /*moment().locale('it');*/

      $('#myscheduler').fullscheduler();
      {/literal}
        {if and($content.input.startDateTime, $content.input.endDateTime, $content.input.recurrencePattern)}
            {literal}
              $('#myScheduler').fullscheduler('value', {
                startDateTime: "{/literal}{$content.input.startDateTime}{literal}",
                endDateTime: "{/literal}{$content.input.endDateTime}{literal}",
                /*timeZone: "W. Europe Standard Time",*/
                recurrencePattern: "{/literal}{$content.input.recurrencePattern}{literal}"
              });
            {/literal}
        {/if}
      {literal}

      $('#myScheduler').on('changed.fu.fullscheduler', function () {
        var input = $('#myScheduler').fullscheduler('value');
        $('#demoInput').val(JSON.stringify(input));
        $.ajax({
          type: "POST",
          url: "{/literal}{'/recurrence/parse'|ezurl(no)}{literal}",
          data: input,
          success: function (data) {
            $('#demoResult1').val(data.text);
            $('#demoResult2').val(JSON.stringify(data.recurrences));

            $('#calendar').fullCalendar('removeEvents');
            $('#calendar').fullCalendar('addEventSource', data.recurrences);

          }
        });
      });


      // Calendar
      $('#calendar').fullCalendar({
        locale: 'it',
        header: {
          left: 'prev,next',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        timeFormat: 'H:mm',
        axisFormat: 'H(:mm)',
        aspectRatio: 1.35,
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events: [
          {/literal}{foreach $content.events as $r}{/literal}
              {
                id: '{/literal}{$r.id}{literal}',
                start: '{/literal}{$r.start}{literal}',
                end: '{/literal}{$r.end}{literal}'
              }
          {/literal}{delimiter},{/delimiter}{/foreach}{literal}
        ],
        eventClick: function(event, element) {
          // Display the modal and set the values to the event values.
          $('.modal').modal('show');
          /*$('.modal').find('#title').val(event.title);
          $('.modal').find('#starts-at').val( moment(event.start).format('YYYY-MM-DD HH:mm:ss') );
          $('.modal').find('#ends-at').val( moment(event.end).format('YYYY-MM-DD HH:mm:ss') );*/

          $('.modal').find('#starts-at').val( moment(event.start).format('DD/MM/YYYY HH:mm') );
          $('.modal').find('#ends-at').val( moment(event.end).format('DD/MM/YYYY HH:mm') );


          $('#save-event').on('click', function() {
            event.start = moment( $('#starts-at').val(), 'DD/MM/YYYY HH:mm' ).format();
            event.end = moment( $('#ends-at').val(), 'DD/MM/YYYY HH:mm' ).format();

            // Update event
            $('#calendar').fullCalendar('updateEvent', event);
            // Clear modal inputs
            $('.modal').find('input').val('');
            // hide modal
            //$('.modal').modal('hide');

            // Unbind event on button
            $( "#save-event").unbind( "click" );
          });

          $('#delete-event').on('click', function() {
            $('#calendar').fullCalendar( 'removeEvents', event.id );

            // Unbind event on button
            $( "#delete-event").unbind( "click" );
          });
        },

        eventAfterAllRender: function (view) {
          /*console.log( $("#calendar").fullCalendar('clientEvents'));*/
          var json = JSON.stringify( $("#calendar").fullCalendar("clientEvents").map(function(e) {
            return {
              id: e.id,
              start: moment(e.start).format(),
              end: moment(e.end).format()
            };
          }));
          $('#events').val(json);
        }


      });

      // Bind the dates to datetimepicker.
      $("#starts-at, #ends-at").datetimepicker({
        locale: 'it'
      });


    });


    {/literal}
</script>



