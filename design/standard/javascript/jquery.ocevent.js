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
    rule: null,

    update: function () {

      switch( ocevent.fields.recurrence.val() ) {
        case 'none':
          console.log('none')
          break;

        // Daily
        case '3':
          ocevent.rule = new RRule({
            dtstart: moment( ocevent.fields.startDate.val() , 'DD/MM/YYYY HH:mm').toDate(),
            freq: ocevent.fields.recurrence.val(),
            interval: ocevent.fields.interval.val(),
            until: ocevent.fields.until.val() !== '' ? moment( ocevent.fields.until.val() , 'DD/MM/YYYY HH:mm').toDate() : ocevent.maxDate.toDate(),
          });
          console.log(this.rule.toString());
          break;

        // Weekly
        case '2':
          ocevent.rule = new RRule({
            dtstart: moment( ocevent.fields.startDate.val() , 'DD/MM/YYYY HH:mm').toDate(),
            freq: ocevent.fields.recurrence.val(),
            interval: ocevent.fields.interval.val(),
            until: ocevent.fields.until.val() !== '' ? moment( ocevent.fields.until.val() , 'DD/MM/YYYY HH:mm').toDate() : ocevent.maxDate.toDate(),
            byweekday: ocevent.getWeeklyValues()
          });
          console.log(this.rule.toString());
          break;

        // Monthly
        case '1':
          ocevent.rule = new RRule({
            dtstart: moment( ocevent.fields.startDate.val() , 'DD/MM/YYYY HH:mm').toDate(),
            freq: ocevent.fields.recurrence.val(),
            interval: ocevent.fields.interval.val(),
            until: ocevent.fields.until.val() !== '' ? moment( ocevent.fields.until.val() , 'DD/MM/YYYY HH:mm').toDate() : ocevent.maxDate.toDate(),
          });
          console.log(this.rule.toString());
          break;
        default:
          console.log('error');
      }


    },

    onChangeRecurrence: function () {
      this.fields.recurrence.on('change', function () {
        if ($(this).val() == 'rf') {
          cl.$root.find('#multiplier_ev_label').text('RF(%)')
          cl.$root.find('#multiplier_refund-stake-container').removeClass('invisible');
        } else {
          cl.$root.find('#multiplier_ev_label').text('Rating(%)')
          cl.$root.find('#multiplier_refund-stake-container').addClass('invisible')
        }
        cl._update();
      });
    },

    update: function() {
      var values = this.container.find('input[type=checkbox]:checked').map(function(_, el) {
        return $(el).val();
      }).get();
      console.log(values);
      return values;
    },

    triggerChange: function () {

      
      this.container.find("input, select").on('change', function () {
        ocevent.update();
      });

      $('.ocevent-calendar').on('dp.change', function(e){
        ocevent.update();
      })
    },

    init: function (options) {
      console.log(options);

      this.attributeId = options.attributeId;
      this.container = $('#ocevent_attribute_' +  this.attributeId);


      if (this.container.length > 0) {
        this.fields.startDate = this.container.find('.startDate');
        this.fields.endDate = this.container.find('.endDate');
        this.fields.recurrence = this.container.find('.recurrence');
        this.fields.interval = this.container.find('.interval');
        //this.fields.count = this.container.find('.count');
        this.fields.until = this.container.find('.until');




        // Bind the dates to datetimepicker.
        this.fields.startDate.datetimepicker({
          locale: moment().local('it'),
          defaultDate: moment()
        });
        this.fields.endDate.datetimepicker({
          locale: moment().local('it'),
          defaultDate: moment().add(2, 'hours')
        });

        this.fields.until.datetimepicker({
          locale: moment().local('it'),
          format: 'L',
          maxDate: ocevent.maxDate
        });

        this.triggerChange();
      }





      /*this.rule = new RRule({
        freq: RRule.WEEKLY,
        count: 30,
        bymonthday: [15]
      });
      console.log(this.rule.toString());*/
    }

  }

  $.ocevent = ocevent;

}(jQuery));
