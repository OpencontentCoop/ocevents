<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Recurrence full calendar demo</title>
  <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css" rel="stylesheet"/>

</head>
<body>

<div class="container">
  <div class="row">
    <div class="col-md-12">

      <h1>Recurrence full calendar demo</h1>
      <div id='calendar'></div>

    </div>
  </div>

</div>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/locale/it.js"></script>

<script>
  {literal}
  $(document).ready(function () {
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
      editable: false,
      eventLimit: false, // allow "more" link when too many events
      events: []
    });
  });
  {/literal}
</script>

