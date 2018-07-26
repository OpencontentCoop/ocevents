{ezcss_require(array('fullcalendar.min.css'))}
<div id='calendar-{$attribute.id}'></div>
{ezscript_require(array(
'ezjsc::jquery',
'bootstrap.min.js',
'moment-with-locales.min.js',
'fullcalendar/fullcalendar.min.js',
'fullcalendar/locale/it.js'))}

<script>
  {literal}
  $(document).ready(function () {
    $('#calendar-{/literal}{$attribute.id}{literal}').fullCalendar({
      locale: 'it',
      defaultDate: {/literal}{if is_set($attribute.content.events[0])}moment('{$attribute.content.events[0].start}'){else}moment(){/if}{/literal},
      header: {
        left: 'prev,next',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      timeFormat: 'H:mm',
      axisFormat: 'H(:mm)',
      aspectRatio: 1.35,
      navLinks: true, // can click day/week names to navigate views
      editable: false,
      eventLimit: false, // allow "more" link when too many events
      events: [
        {/literal}{foreach $attribute.content.events as $r}{/literal}
        {
          id: '{/literal}{$r.id}{literal}',
          start: '{/literal}{$r.start}{literal}',
          end: '{/literal}{$r.end}{literal}'
        }
        {/literal}{delimiter},{/delimiter}{/foreach}{literal}
      ]
    });
  });

  {/literal}
</script>
