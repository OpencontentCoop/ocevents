(function ($) {

  const ocevent = {

    attributeId: null,
    container: null,
    fields: {
      startDate: null,
      endDate: null,
      recurrence: null,
      interval: null,
      count: null,
      until: null,
    },
    maxDate: moment().add(30, 'years'),
    endpoint: null,
    rule: null,

    hideAll: function () {
      ocevent.container.find('.interval-container, .weekly-container, .monthly-container, .untiltype-container').addClass('hide');
    },

    onRecurrenceChange: function () {
      ocevent.fields.recurrence.on('change', function () {
        ocevent.showByRecurenceValue();
      });
    },

    showByRecurenceValue: function () {
      ocevent.hideAll();
      switch (ocevent.fields.recurrence.val()) {
        case 'none':
          //console.log('none')
          break;

        // Daily
        case '3':
          ocevent.container.find('.interval-container, .untiltype-container').removeClass('hide');
          break;

        // Weekly
        case '2':
          ocevent.container.find('.interval-container, .weekly-container, .untiltype-container').removeClass('hide');
          break;

        // Monthly
        case '1':
          ocevent.container.find('.interval-container, .monthly-container, .untiltype-container').removeClass('hide');
          break;
        default:
          console.log('error');
      }
    },

    update: function () {
      switch (ocevent.fields.recurrence.val()) {
        case 'none':
          //console.log('none')
          ocevent.hideAll();

          //pattern = 'FREQ=DAILY;INTERVAL=1;COUNT=1;'
          ocevent.rule = new RRule({
            dtstart: moment(ocevent.fields.startDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            dtend: moment(ocevent.fields.endDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            freq: '3',
            interval: '1',
            count: '1'
          });
          this.generateData();
          break;

        // Daily
        case '3':
          ocevent.rule = new RRule({
            dtstart: moment(ocevent.fields.startDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            dtend: moment(ocevent.fields.endDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            freq: ocevent.fields.recurrence.val(),
            interval: ocevent.fields.interval.val(),
            until: ocevent.fields.until.val() !== '' ? moment(ocevent.fields.until.val(), 'DD/MM/YYYY').toDate() : ocevent.maxDate.toDate()
          });
          this.generateData();
          break;

        // Weekly
        case '2':
          ocevent.rule = new RRule({
            dtstart: moment(ocevent.fields.startDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            dtend: moment(ocevent.fields.endDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            freq: ocevent.fields.recurrence.val(),
            interval: ocevent.fields.interval.val(),
            until: ocevent.fields.until.val() !== '' ? moment(ocevent.fields.until.val(), 'DD/MM/YYYY').toDate() : ocevent.maxDate.toDate(),
            byweekday: ocevent.getWeeklyValues()
          });
          this.generateData();
          break;

        // Monthly
        case '1':
          ocevent.rule = new RRule({
            dtstart: moment(ocevent.fields.startDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            dtend: moment(ocevent.fields.endDate.val(), 'DD/MM/YYYY HH:mm').toDate(),
            freq: ocevent.fields.recurrence.val(),
            interval: ocevent.fields.interval.val(),
            until: ocevent.fields.until.val() !== '' ? moment(ocevent.fields.until.val(), 'DD/MM/YYYY').toDate() : ocevent.maxDate.toDate()
          });
          this.generateData();
          break;
        default:
          console.log('error');
      }
    },

    generateData: function () {
      var self = this;
      var input = {
        startDateTime: moment(ocevent.fields.startDate.val(), 'DD/MM/YYYY HH:mm').format(),
        endDateTime: moment(ocevent.fields.endDate.val(), 'DD/MM/YYYY HH:mm').format(),
        freq: ocevent.fields.recurrence.val(),
        interval: ocevent.fields.interval.val(),
        until: moment(ocevent.fields.until.val(), 'DD/MM/YYYY').format(),
        byweekday: ocevent.getWeeklyValues(),
        timeZone: {
          offset: moment(ocevent.fields.startDate.val(), 'DD/MM/YYYY HH:mm').format('Z')
        },
        recurrencePattern: this.rule.toString()
      };
      //console.log(input);

      $.ajax({
        type: "POST",
        url: ocevent.endpoint,
        data: input,
        success: function (data) {
          $('#events_input').val(JSON.stringify(input));
          $('#events_text').val(data.text);
          $('#events_recurrences').val(JSON.stringify(data.recurrences));

          if (data.recurrences.length > 1) {
            self.container.find('.calendar').removeClass('hide');
          } else {
            self.container.find('.calendar').addClass('hide');
          }
          ocevent.calendar.fullCalendar('removeEvents');
          ocevent.calendar.fullCalendar('addEventSource', data.recurrences);
          if (data.recurrences.length > 0) {
            ocevent.calendar.fullCalendar('gotoDate', moment(data.recurrences[0].start));
          }
        },
        error: function (jqXHR) {
          console.log(jqXHR.responseJSON.error);
          if (jqXHR.responseJSON.code === 100) {
            self.fields.endDate.data("DateTimePicker").date(new Date(moment(input.startDateTime).add('1', 'minutes').format()));
          }
        }
      });
    },

    getWeeklyValues: function () {
      return this.container.find('input[type=checkbox]:checked').map(function (_, el) {
        return $(el).val();
      }).get();
    },

    bindChange: function () {
      this.container.find("input, select").on('change', function () {
        ocevent.update();
      });

      $('.ocevent-calendar').on('dp.change', function (e) {
        ocevent.update();
      });
    },

    initCalendar: function () {

      var events = [];
      if ($('#events').val() !== '') {
        events = JSON.parse($('#events').val());
      }

      this.calendar = this.container.find('.calendar');
      // Calendar
      this.calendar.fullCalendar({
        locale: 'it',
        defaultDate: moment(),
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
        events: events,
        eventClick: function (event, element) {
          // Display the modal and set the values to the event values.
          ocevent.modal.modal('show');
          ocevent.modal.find('#starts-at').val(moment(event.start).format('DD/MM/YYYY HH:mm'));
          ocevent.modal.find('#ends-at').val(moment(event.end).format('DD/MM/YYYY HH:mm'));

          ocevent.modal.find('#save-event').on('click', function () {
            event.start = moment($('#starts-at').val(), 'DD/MM/YYYY HH:mm').format();
            event.end = moment($('#ends-at').val(), 'DD/MM/YYYY HH:mm').format();
            // Update event
            ocevent.calendar.fullCalendar('updateEvent', event);
            // Clear modal inputs
            ocevent.modal.find('input').val('');
            // hide modal
            //modal.modal('hide');
            // Unbind event on button
            $("#save-event").unbind("click");
          });

          ocevent.modal.find('#delete-event').on('click', function () {
            ocevent.calendar.fullCalendar('removeEvents', event.id);
            // Unbind event on button
            $("#delete-event").unbind("click");
          });
        },

        eventAfterAllRender: function (view) {
          var json = JSON.stringify(ocevent.calendar.fullCalendar("clientEvents").map(function (e) {
            return {
              id: e.id,
              start: moment(e.start).format(),
              end: moment(e.end).format()
            };
          }));
          $('#events').val(json);
        }
      });

      if (events.length <= 1) {
        this.container.find('.calendar').addClass('hide');
      }
    },

    initModal: function () {
      this.modal = this.container.find('.modal');

      // Bind the dates to datetimepicker.
      this.modal.find("#starts-at, #ends-at").datetimepicker({
        locale: 'it',
      });
    },

    init: function (options) {
      //console.log(options);

      moment().locale('it');

      this.attributeId = options.attributeId;
      this.endpoint = options.endpoint;
      this.container = $('#ocevent_attribute_' + this.attributeId);

      if (this.container.length > 0) {
        this.fields.startDate = this.container.find('.startDate');
        this.fields.endDate = this.container.find('.endDate');
        this.fields.recurrence = this.container.find('.recurrence');
        this.fields.interval = this.container.find('.interval');
        this.fields.until = this.container.find('.until');

        // Bind datepicker to start input
        this.fields.startDate.datetimepicker({
          locale: moment().local('it'),
          defaultDate: moment().set('hour', 10).set('minute', 0)
        });

        // Bind datepicker to end input
        this.fields.endDate.datetimepicker({
          locale: moment().local('it'),
          defaultDate: moment().set('hour', 12).set('minute', 0)
        });

        // Bind datepicker to until input
        this.fields.until.datetimepicker({
          locale: moment().local('it'),
          format: 'L',
          maxDate: ocevent.maxDate,
          defaultDate: moment().add(6, 'months')
        });

        // Init calendar
        this.initCalendar();

        // Init modal
        this.initModal();

        //
        this.onRecurrenceChange();
        this.showByRecurenceValue();
        this.bindChange();
      }
    }

  };

  $.ocevent = ocevent;

}(jQuery));
