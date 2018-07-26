{if $attribute.has_content}
    {def $content = $attribute.content}
{/if}

<div class="row fuelux">
    <div class="col-md-12">
        <div class="form-horizontal scheduler" role="form" id="{concat('scheduler_', $attribute.id)}">
            <div class="row form-group start-datetime">
                <label class="col-sm-12 scheduler-label" for="myStartDate">{'Start'|i18n('ocevents/attribute')}</label>
                <div class="col-sm-9 form-group">
                    <div class="datepicker start-date">
                        <div class="input-group">
                            <input class="form-control" id="myStartDate" type="text"/>
                            {include uri='design:content/datatype/edit/parts/datepicker.tpl'}
                        </div>
                    </div>
                </div>

                <div class="col-sm-3 form-group">
                    <label class="sr-only" for="MyStartTime">{'Start Time'|i18n('ocevents/attribute')}Start Time</label>
                    <div class="input-group combobox start-time">
                        <input id="myStartTime" type="text" class="form-control"/>
                        {include uri='design:content/datatype/edit/parts/timepicker.tpl'}
                    </div>
                </div>
            </div>

            <div class="row form-group end-datetime">
                <label class="col-sm-12 scheduler-label" for="myEndDate">{'End'|i18n('ocevents/attribute')}</label>
                <div class="col-sm-9 form-group">
                    <div class="datepicker end-date">
                        <div class="input-group">
                            <input class="form-control" id="myEndDate" type="text"/>
                            {include uri='design:content/datatype/edit/parts/datepicker.tpl'}
                        </div>
                    </div>
                </div>

                <div class="col-sm-3 form-group">
                    <label class="sr-only" for="MyEndTime">{'End Time'|i18n('ocevents/attribute')}</label>
                    <div class="input-group combobox end-time">
                        <input id="myEndTime" type="text" class="form-control"/>
                        {include uri='design:content/datatype/edit/parts/timepicker.tpl'}
                    </div>
                </div>
            </div>

            <div class="row form-group timezone-container hide">
                <label class="col-sm-2 control-label scheduler-label">{'Timezone'|i18n('ocevents/attribute')}</label>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <div data-resize="auto" class="btn-group selectlist timezone">
                        <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                            <span class="selected-label">(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna *</span>
                            <span class="caret"></span>
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li data-name="W. Europe Standard Time" data-offset="+01:00"><a href="#">(GMT+01:00)
                                    Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna *</a></li>
                        </ul>
                        <input type="text" aria-hidden="true" readonly="readonly" name="TimeZoneSelectlist"
                               class="hidden hidden-field">
                    </div>
                </div>
            </div>

            <div class="form-group repeat-container">
                <label class="col-sm-12 scheduler-label">{'Recurrence'|i18n('ocevents/attribute')}</label>

                <div class="col-sm-10">
                    <div class="form-group repeat-interval">
                        <div data-resize="auto"
                             class="btn-group selectlist pull-left repeat-options">
                            <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                <span class="selected-label"></span>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li data-value="none"><a href="#">{'None (run once)'|i18n('ocevents/attribute')}</a>
                                </li>
                                {*<li data-value="hourly" data-text="hour(s)"><a href="#">Hourly</a></li>*}
                                <li data-value="daily" data-text="day(s)"><a
                                            href="#">{'Daily'|i18n('ocevents/attribute')}</a></li>
                                {*<li data-value="weekdays"><a href="#">Weekdays</a></li>*}
                                <li data-value="weekly" data-text="week(s)"><a
                                            href="#">{'Weekly'|i18n('ocevents/attribute')}</a></li>
                                <li data-value="monthly" data-text="month(s)"><a
                                            href="#">{'Monthly'|i18n('ocevents/attribute')}</a></li>
                                {*<li data-value="yearly"><a href="#">Yearly</a></li>*}
                            </ul>
                            <input type="text" aria-hidden="true" readonly="readonly" name="intervalSelectlist"
                                   class="hidden hidden-field">
                        </div>

                        <div class="repeat-panel repeat-every-panel repeat-hourly repeat-daily repeat-weekly hide"
                             aria-hidden="true">
                            <label id="MySchedulerEveryLabel"
                                   class="inline-form-text repeat-every-pretext">{'every'|i18n('ocevents/attribute')}</label>
                            <div class="spinbox digits-3 repeat-every">
                                <input type="text" class="form-control input-mini spinbox-input"
                                       aria-labelledby="MySchedulerEveryLabel">
                                <div class="spinbox-buttons btn-group btn-group-vertical">
                                    <button type="button" class="btn btn-default spinbox-up btn-xs">
                                        <span class="glyphicon glyphicon-chevron-up"></span><span class="sr-only">Increase</span>
                                    </button>
                                    <button type="button" class="btn btn-default spinbox-down btn-xs">
                                        <span class="glyphicon glyphicon-chevron-down"></span><span class="sr-only">Decrease</span>
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
                                <input type="checkbox" data-value="MO"> {'Mon'|i18n('ocevents/attribute')}
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="TU"> {'Tue'|i18n('ocevents/attribute')}
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="WE"> {'Wed'|i18n('ocevents/attribute')}
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="TH"> {'Thu'|i18n('ocevents/attribute')}
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="FR"> {'Fri'|i18n('ocevents/attribute')}
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="SA"> {'Sat'|i18n('ocevents/attribute')}
                            </label>
                            <label class="btn btn-default">
                                <input type="checkbox" data-value="SU">{'Sun'|i18n('ocevents/attribute')}
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
                                    <input class="sr-only" type="radio" checked="checked" name="repeat-monthly"
                                           value="bysetpos">
                                    <span class="radio-label">{'on the'|i18n('ocevents/attribute')}</span>
                                </label>
                            </div>

                            <div data-resize="auto" class="btn-group selectlist month-day-pos pull-left">
                                {*<button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                  <span class="selected-label">{'First'|i18n('ocevents/attribute')}</span>
                                  <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                  <li data-value="1"><a href="#">{'First'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="2"><a href="#">{'Second'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="3"><a href="#">{'Third'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="4"><a href="#">{'Fourth'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="-1"><a href="#">{'Last'|i18n('ocevents/attribute')}</a></li>
                                </ul>*}
                                {include uri='design:content/datatype/edit/parts/numbers.tpl'}
                                <input type="text" aria-hidden="true" readonly="readonly" name="monthlySelectlist"
                                       class="hidden hidden-field">
                            </div>

                            <div data-resize="auto" class="btn-group selectlist month-days pull-left">
                                {*<button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                  <span class="selected-label">{'Sunday'|i18n('ocevents/attribute')}</span>
                                  <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                  <li data-value="SU"><a href="#">{'Sunday'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="MO"><a href="#">{'Monday'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="TU"><a href="#">{'Tuesday'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="WE"><a href="#">{'Wednesday'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="TH"><a href="#">{'Thursday'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="FR"><a href="#">{'Friday'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="SA"><a href="#">{'Saturday'|i18n('ocevents/attribute')}</a></li>
                                  *}{*<li data-value="SU,MO,TU,WE,TH,FR,SA"><a href="#">Day</a></li>
                  <li data-value="MO,TU,WE,TH,FR"><a href="#">Weekday</a></li>
                  <li data-value="SU,SA"><a href="#">Weekend day</a></li>*}{*
                </ul>*}
                                {include uri='design:content/datatype/edit/parts/weekdays.tpl'}
                                <input type="text" aria-hidden="true" readonly="readonly" name="monthlySelectlist"
                                       class="hidden hidden-field">
                            </div>

                        </div>
                    </div>

                    <div class="repeat-panel repeat-yearly hide" aria-hidden="true">

                        <div class="form-group repeat-yearly-date">

                            <div class="radio pull-left">
                                <label class="radio-custom">
                                    <input class="sr-only" type="radio" checked="checked" name="repeat-yearly"
                                           value="bymonthday">
                                    <span class="radio-label">{'on'|i18n('ocevents/attribute')}</span>
                                </label>
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month pull-left">
                                {*<button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                  <span class="selected-label">{'January'|i18n('ocevents/attribute')}</span>
                                  <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                  <li data-value="1"><a href="#">{'January'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="2"><a href="#">{'February'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="3"><a href="#">{'March'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="4"><a href="#">{'April'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="5"><a href="#">{'May'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="6"><a href="#">{'June'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="7"><a href="#">{'July'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="8"><a href="#">{'August'|i18n('ocevents/attribute')}August</a></li>
                                  <li data-value="9"><a href="#">{'September'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="10"><a href="#">{'October'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="11"><a href="#">{'November'|i18n('ocevents/attribute')}</a></li>
                                  <li data-value="12"><a href="#">{'December'|i18n('ocevents/attribute')}</a></li>
                                </ul>*}
                                {include uri='design:content/datatype/edit/parts/months.tpl'}
                                <input type="text" aria-hidden="true" readonly="readonly" name="monthlySelectlist"
                                       class="hidden hidden-field">
                            </div>

                            <div data-resize="auto"
                                 class="btn-group selectlist year-month-day pull-left">
                                <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                    <span class="selected-label">1</span>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu" style="height:200px; overflow:auto;">
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
                                <input type="text" aria-hidden="true" readonly="readonly" name="monthlySelectlist"
                                       class="hidden hidden-field">
                            </div>
                        </div>

                        <div class="form-group repeat-yearly-day">

                            <div class="radio pull-left">
                                <label class="radio-custom"><input class="sr-only" type="radio" name="repeat-yearly"
                                                                   value="bysetpos">{'on the'|i18n('ocevents/attribute')}
                                </label>
                            </div>

                            <div data-resize="auto" class="btn-group selectlist year-month-day-pos pull-left">
                                {*<button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
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
                                </ul>*}
                                {include uri='design:content/datatype/edit/parts/numbers.tpl'}
                                <input type="text" aria-hidden="true" readonly="readonly" name="yearlyDateSelectlist"
                                       class="hidden hidden-field">
                            </div>

                            <div data-resize="auto" class="btn-group selectlist year-month-days pull-left">
                                {*<button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                  <span class="selected-label">Sunday</span>
                                  <span class="caret"></span>
                                  <span class="sr-only">Sunday</span>
                                </button>
                                <ul class="dropdown-menu" role="menu" style="height:200px; overflow:auto;">
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
                                </ul>*}
                                {include uri='design:content/datatype/edit/parts/weekdays.tpl'}
                                <input type="text" aria-hidden="true" readonly="readonly" name="yearlyDaySelectlist"
                                       class="hidden hidden-field">
                            </div>
                            <div class="inline-form-text repeat-yearly-day-text"> of</div>

                            <div data-resize="auto" class="btn-group selectlist year-month pull-left">
                                {*<button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
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
                                </ul>*}
                                {include uri='design:content/datatype/edit/parts/months.tpl'}
                                <input type="text" aria-hidden="true" readonly="readonly" name="yearlyDaySelectlist"
                                       class="hidden hidden-field">
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="form-group repeat-end hide" aria-hidden="true">
                <label class="col-sm-12 scheduler-label">{'End recurrence'|i18n('ocevents/attribute')}</label>
                <div class="col-sm-12 row">
                    <div class="col-sm-4 form-group">
                        <div data-resize="auto"
                             class="btn-group selectlist end-options pull-left">
                            <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                <span class="selected-label">{'Never'|i18n('ocevents/attribute')}</span>
                                <span class="caret"></span>
                                <span class="sr-only">{'Never'|i18n('ocevents/attribute')}</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li data-value="never"><a href="#">{'Never'|i18n('ocevents/attribute')}</a></li>
                                <li data-value="after"><a href="#">{'After'|i18n('ocevents/attribute')}</a></li>
                                <li data-value="date"><a href="#">{'On date'|i18n('ocevents/attribute')}</a></li>
                            </ul>
                            <input type="text" aria-hidden="true" readonly="readonly" name="EndSelectlist"
                                   class="hidden hidden-field">
                        </div>
                    </div>

                    <div class="col-sm-6 form-group end-option-panel end-after-panel pull-left hide"
                         aria-hidden="true">
                        <div class="spinbox digits-3 end-after">
                            <label id="MyEndAfter" class="sr-only">{'End After'|i18n('ocevents/attribute')}</label>
                            <input type="text" class="form-control input-mini spinbox-input"
                                   aria-labelledby="MyEndAfter">
                            <div class="spinbox-buttons btn-group btn-group-vertical">
                                <button type="button" class="btn btn-default spinbox-up btn-xs">
                                    <span class="glyphicon glyphicon-chevron-up"></span><span
                                            class="sr-only">Increase</span>
                                </button>
                                <button type="button" class="btn btn-default spinbox-down btn-xs">
                                    <span class="glyphicon glyphicon-chevron-down"></span><span
                                            class="sr-only">Decrease</span>
                                </button>
                            </div>
                        </div>
                        <div class="inline-form-text end-after-text">{'occurance(s)'|i18n('ocevents/attribute')}</div>
                    </div>

                    <div class="col-sm-8 form-group end-option-panel end-on-date-panel pull-left hide"
                         aria-hidden="true">
                        <div class="datepicker input-group end-on-date">
                            <div class="input-group">
                                <input class="form-control" type="text"/>
                                {include uri='design:content/datatype/edit/parts/datepicker.tpl'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row{if ezini('DebugSettings', 'DebugOutput')|eq('disabled')} hide{/if}">
    <div class="col-md-12">
        <input type="hidden" id="has_content" value="{$attribute.has_content}">
        <h3>Text</h3>
        <textarea id="events_text" name="{$attribute_base}_ocevent_data_{$attribute.id}[text]" rows="1" cols="50"
                  class="form-control">{if is_set($content.text)}{$content.text}{/if}</textarea>

        <h3>Input</h3>
        <textarea id="events_input" name="{$attribute_base}_ocevent_data_{$attribute.id}[input]" rows="10" cols="50"
                  class="form-control">{if is_set($content.input_json)}{$content.input_json}{/if}</textarea>

        <h3>Recurrences</h3>
        <textarea id="events_recurrences" name="{$attribute_base}_ocevent_data_{$attribute.id}[recurrences]" rows="10"
                  cols="50"
                  class="form-control">{if is_set($content.recurrences_json)}{$content.recurrences_json}{/if}</textarea>

        <h3>Events</h3>
        <textarea id="events" name="{$attribute_base}_ocevent_data_{$attribute.id}[events]" rows="10" cols="50"
                  class="form-control">{if is_set($content.events_json)}{$content.events_json}{/if}</textarea>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <div id='calendar'></div>
    </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h3 class="modal-title">Modifica singolo evento</h3>
            </div>
            <div class="modal-body">
                <input type="hidden" id="title"/>
                <div class="form-group">
                    <label for="starts-at">Inizio</label>
                    <input type="text" class="form-control" name="starts_at" id="starts-at">
                </div>
                <div class="form-group">
                    <label for="ends-at">Fine</label>
                    <input type="text" class="form-control" name="ends_at" id="ends-at">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-left" data-dismiss="modal" id="delete-event"><i
                            class="fa fa-trash"></i> Elimina
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal" id="save-event"><i
                            class="fa fa-save"></i> Salva
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

{ezcss_require(array('fuelux.min.css', 'fullcalendar.min.css'))}
<style>
{literal}
.fuelux .scheduler .end-datetime.form-group {margin-bottom: 0;}
.fuelux .radio-label {margin-left: 25px;}
.fuelux .scheduler .end-datetime .form-group {margin-left: 0;}
.fuelux .scheduler .repeat-interval .dropdown-menu,
.fuelux .datepicker-calendar-wrapper {width: auto !important;}
.fuelux .scheduler .start-datetime .combobox {max-width: none;}
.fuelux .scheduler .selectlist button{white-space: nowrap !important;width: auto !important;}
.modal {margin-top: 200px;}
{/literal}
</style>

{ezscript_require(array(
'ezjsc::jquery',
'ezjsc::jqueryUI',
'bootstrap.min.js',
'moment-with-locales.min.js',
'fuelux.min.js',
'fullscheduler.js',
'fullcalendar/fullcalendar.min.js',
'fullcalendar/locale/it.js',
'bootstrap-datetimepicker.min.js'
))}


<script>
    {literal}
    $(document).ready(function () {

        var calendar = $('#calendar');
        var modal = $('.modal');

        // Fix button event on datepicker
        $('.datepicker-calendar :button, .datepicker-wheels *').on('click click.fu.datepicker', function (event) {
            event.preventDefault();
        });
        moment().locale('it');

        var scheduler = $("#{/literal}{concat('scheduler_', $attribute.id)}{literal}");
        scheduler.fullscheduler({
            startDateOptions: {
                allowPastDates: true
            },
            endDateOptions: {
                allowPastDates: true
            },
            untilDateOptions: {
                allowPastDates: true
            }
        });

        {/literal}
        {if and(is_set($content.input), $content.input.startDateTime, $content.input.endDateTime, $content.input.recurrencePattern)}
        {literal}
        scheduler.fullscheduler('value', {
            startDateTime: "{/literal}{$content.input.startDateTime}{literal}",
            endDateTime: "{/literal}{$content.input.endDateTime}{literal}",
            recurrencePattern: "{/literal}{$content.input.recurrencePattern}{literal}"
        });
        {/literal}
        {/if}
        {literal}

        scheduler.on('changed.fu.fullscheduler', function () {
            var input = scheduler.fullscheduler('value');
            $('#events_input').val(JSON.stringify(input));
            $.ajax({
                type: "POST",
                url: "{/literal}{'/recurrence/parse'|ezurl(no)}{literal}",
                data: input,
                success: function (data) {
                    $('#events_text').val(data.text);
                    $('#events_recurrences').val(JSON.stringify(data.recurrences));

                    calendar.fullCalendar('removeEvents');
                    calendar.fullCalendar('addEventSource', data.recurrences);
                    if (data.recurrences.length > 0) {
                        calendar.fullCalendar('gotoDate', moment(data.recurrences[0].start));
                    }
                }
            });
        });

        // Calendar
        calendar.fullCalendar({
            locale: 'it',
            defaultDate: {/literal}{if is_set($content.events[0])}moment('{$content.events[0].start}'){else}moment(){/if}{/literal},
            header: {
                left: 'title',
                center: '',
                right: 'prev,next'
            },
            timeFormat: 'H:mm',
            axisFormat: 'H(:mm)',
            aspectRatio: 1.35,
            navLinks: true, // can click day/week names to navigate views
            editable: true,
            eventLimit: false, // allow "more" link when too many events
            events: [
                {/literal}{if is_set($content.events)}{foreach $content.events as $r}{/literal}
                {
                    id: '{/literal}{$r.id}{literal}',
                    start: '{/literal}{$r.start}{literal}',
                    end: '{/literal}{$r.end}{literal}'
                }
                {/literal}{delimiter},{/delimiter}{/foreach}{/if}{literal}
            ],
            eventClick: function (event, element) {
                // Display the modal and set the values to the event values.
                modal.modal('show');
                modal.find('#starts-at').val(moment(event.start).format('DD/MM/YYYY HH:mm'));
                modal.find('#ends-at').val(moment(event.end).format('DD/MM/YYYY HH:mm'));


                $('#save-event').on('click', function () {
                    event.start = moment($('#starts-at').val(), 'DD/MM/YYYY HH:mm').format();
                    event.end = moment($('#ends-at').val(), 'DD/MM/YYYY HH:mm').format();
                    // Update event
                    calendar.fullCalendar('updateEvent', event);
                    // Clear modal inputs
                    modal.find('input').val('');
                    // hide modal
                    //modal.modal('hide');
                    // Unbind event on button
                    $("#save-event").unbind("click");
                });

                $('#delete-event').on('click', function () {
                    calendar.fullCalendar('removeEvents', event.id);
                    // Unbind event on button
                    $("#delete-event").unbind("click");
                });
            },

            eventAfterAllRender: function (view) {
                var json = JSON.stringify($("#calendar").fullCalendar("clientEvents").map(function (e) {
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


