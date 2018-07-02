<div class="input-group-btn fuelux-datepicker">
    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
        <span class="glyphicon glyphicon-calendar"></span>
        <span class="sr-only">Toggle Calendar</span>
    </button>
    <div class="dropdown-menu dropdown-menu-right datepicker-calendar-wrapper" role="menu">
        <div class="datepicker-calendar">
            <div class="datepicker-calendar-header">
                <button class="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous Month</span>
                </button>
                <button class="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next Month</span>
                </button>
                <button class="title">
                    <span class="month">
                        <span data-month="0">{'January'|i18n('ocevents/attribute')}</span>
                        <span data-month="1">{'February'|i18n('ocevents/attribute')}</span>
                        <span data-month="2">{'March'|i18n('ocevents/attribute')}</span>
                        <span data-month="3">{'April'|i18n('ocevents/attribute')}</span>
                        <span data-month="4">{'May'|i18n('ocevents/attribute')}</span>
                        <span data-month="5">{'June'|i18n('ocevents/attribute')}</span>
                        <span data-month="6">{'July'|i18n('ocevents/attribute')}</span>
                        <span data-month="7">{'August'|i18n('ocevents/attribute')}</span>
                        <span data-month="8">{'September'|i18n('ocevents/attribute')}</span>
                        <span data-month="9">{'October'|i18n('ocevents/attribute')}</span>
                        <span data-month="10">{'November'|i18n('ocevents/attribute')}</span>
                        <span data-month="11">{'December'|i18n('ocevents/attribute')}</span>
                    </span>
                    <span class="year"></span>
                </button>
            </div>
            <table class="datepicker-calendar-days">
                <thead>
                <tr>
                    <th>{'Su'|i18n('ocevents/attribute')}</th>
                    <th>{'Mo'|i18n('ocevents/attribute')}</th>
                    <th>{'Tu'|i18n('ocevents/attribute')}</th>
                    <th>{'We'|i18n('ocevents/attribute')}</th>
                    <th>{'Th'|i18n('ocevents/attribute')}</th>
                    <th>{'Fr'|i18n('ocevents/attribute')}</th>
                    <th>{'Sa'|i18n('ocevents/attribute')}</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="datepicker-calendar-footer">
                {*<button class="datepicker-today">Today</button>*}
            </div>
        </div>
        <div class="datepicker-wheels" aria-hidden="true">
            <div class="datepicker-wheels-month">
                <h2 class="header">{'Month'|i18n('ocevents/attribute')}</h2>
                <ul>
                    <li data-month="0"><button>{'Jan'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="1"> <button>{'Feb'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="2"><button>{'Mar'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="3"><button>{'Apr'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="4"><button>{'May'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="5"><button>{'Jun'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="6"><button>{'Jul'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="7"><button>{'Aug'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="8"><button>{'Sep'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="9"><button>{'Oct'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="10"><button>{'Nov'|i18n('ocevents/attribute')}</button></li>
                    <li data-month="11"><button>{'Dec'|i18n('ocevents/attribute')}</button></li>
                </ul>
            </div>
            <div class="datepicker-wheels-year">
                <h2 class="header">{'Year'|i18n('ocevents/attribute')}</h2>
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
