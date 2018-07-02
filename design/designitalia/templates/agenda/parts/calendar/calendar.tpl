{ezscript_require( array(
    'ezjsc::jquery',
    'jquery.opendataTools.js',
    'moment-with-locales.min.js',
    'fullcalendar/fullcalendar.js',
    'fullcalendar/locale/it.js',
    'fullcalendar/locale/de.js',
    'fullcalendar/locale/en.js',
    'agenda_helpers.js',
    'jquery.opendataSearchView.js',
    'agenda_filters/base.js',
    'agenda_filters/date.js',
    'agenda.js',
    'jsrender.js'
))}
{ezcss_require(array(
    'fullcalendar.min.css'
))}

{def $filterDefinitions = hash('date','OpenpaAgendaDateFilter')}
{if is_set($filters)|not()}{def $filters = array()}{/if}

{def $current_language=ezini('RegionalSettings', 'Locale')}
{def $moment_language = $current_language|explode('-')[1]|downcase()}

<script>
    moment.locale('{$moment_language}');
    $.opendataTools.settings('is_collaboration_enabled', 'false');
    $.opendataTools.settings('onError', function(errorCode,errorMessage,jqXHR){ldelim}
        console.log(errorMessage + ' (error: '+errorCode+')');
        $("#calendar").html('<div class="alert alert-danger">'+errorMessage+'</div>');
        {rdelim});
    $.opendataTools.settings('endpoint',{ldelim}
        'geo': '{'/opendata/api/geo/search/'|ezurl(no,full)}/',
        'search': '{'/opendata/api/content/search/'|ezurl(no,full)}/',
        'class': '{'/opendata/api/classes/'|ezurl(no,full)}/',
        'tags_tree': '{'/opendata/api/tags_tree/'|ezurl(no,full)}/',
        'fullcalendar': '{'/opendata/api/oceventsfullcalendar/search/'|ezurl(no,full)}/'
    {rdelim});
    {if is_set($calendar_identifier)}
        $.opendataTools.settings('session_key','agenda-{$calendar_identifier}-{$current_language}');
    {/if}
    $.opendataTools.settings('accessPath', "{''|ezurl(no,full)}");
    $.opendataTools.settings('language', "{$current_language}");
    //$.opendataTools.settings('base_query', "classes [test_event] and subtree [20155]");
    $.opendataTools.settings('base_query', "{$base_query}");
    $.opendataTools.settings('locale', "{$moment_language}");

    $(document).ready(function () {ldelim}
        $("#calendar").initSearchView().data('opendataSearchView'){foreach $filters as $filter}.addFilter({$filterDefinitions[$filter]}){/foreach}.init().doSearch();
        //$("#calendar").initSearchView().data('opendataSearchView').init().doSearch();
    {rdelim});


</script>

{include uri='design:agenda/parts/calendar/tpl-spinner.tpl'}
{include uri='design:agenda/parts/calendar/tpl-empty.tpl'}
{include uri='design:agenda/parts/calendar/tpl-load-other.tpl'}
{include uri='design:agenda/parts/calendar/tpl-event.tpl'}
