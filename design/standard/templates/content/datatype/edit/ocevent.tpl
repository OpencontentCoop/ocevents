{ezcss_require(array('ocevent.css', 'fullcalendar.min.css'))}
<style>
  {literal}
  .modal {
    margin-top: 200px;
  }

  {/literal}
</style>

{if $attribute.has_content}
  {def $content = $attribute.content}
{/if}

<div id="{concat('ocevent_attribute_', $attribute.id)}">
  <div class="row">
    <div class="col-md-12">

      <div class="form-group row">
        <div class="col-md-6">
          <label for="StartDate">{'Start'|i18n('ocevents/attribute')}</label>
          <div class="input-group">
            <input type="text" class="form-control ocevent-calendar startDate" id="startDate" name="dtstart">
            <div class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <label for="EndDate">{'End'|i18n('ocevents/attribute')}</label>
          <div class="input-group">
            <input type="text" class="form-control ocevent-calendar endDate" id="EndDate" name="dtEnd">
            <div class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </div>
          </div>
        </div>
      </div>

      <div class="form-group row">
        <div class="col-md-6">
          <div class=" recurrence-container">
            <label>{'Recurrence'|i18n('ocevents/attribute')}</label>
            <select class="form-control recurrence" name="freq">
              <option data-value="none" value="none">{'None (run once)'|i18n('ocevents/attribute')}</option>
              <option data-value="daily" value="3">{'Daily'|i18n('ocevents/attribute')}</option>
              <option data-value="weekly" value="2">{'Weekly'|i18n('ocevents/attribute')}</option>
              <option data-value="monthly" value="1">{'Monthly'|i18n('ocevents/attribute')}</option>
            </select>
          </div>
        </div>
        <div class="col-md-6">
          <div class="interval-container">
            <label>{'every'|i18n('ocevents/attribute')}</label>
            <input class="form-control interval" type="number" min="1" name="interval" value="1">
          </div>
        </div>
      </div>

      <div class="form-group weekly-container">
        <label>{'Select week day'|i18n('ocevents/attribute')}</label>
        <div class="clearfix">
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" checked="checked" value="0"> {'Mon'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="1"> {'Tue'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="2"> {'Wed'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="3"> {'Thu'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="4"> {'Fri'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="5"> {'Sat'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="6">{'Sun'|i18n('ocevents/attribute')}
            </label>
          </div>
        </div>
      </div>

      <div class="form-group monthly-container">
        <label>on day</label>
        <select class="form-control" name="bymonthday">
          {for 1 to 31 as $day}
            <option value="{$day}">{$day}</option>
          {/for}
        </select>
      </div>

      <div class="form-group row untiltype-container">
        <div class="col-md-6">
          <label>{'End recurrence'|i18n('ocevents/attribute')}</label>
          <select class="form-control" name="untiltype">
            <option value="never">{'Never'|i18n('ocevents/attribute')}</option>
            <option value="date">{'On date'|i18n('ocevents/attribute')}</option>
          </select>
        </div>

        <div class="col-md-6">
          <label>{'On date'|i18n('ocevents/attribute')}</label>
          <div class="input-group">
            <input type="text" class="form-control until ocevent-calendar" name="until">
            <div class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </div>
          </div>
        </div>
      </div>


      {*<div class="col-md-6">
        <label>{'End recurrence'|i18n('ocevents/attribute')}</label>
        <select class="form-control" name="EndSelectlist">
          <option value="never">{'Never'|i18n('ocevents/attribute')}</option>
          <option value="after">{'After'|i18n('ocevents/attribute')}</option>
          <option value="date">{'On date'|i18n('ocevents/attribute')}</option>
        </select>
      </div>

      <div class="col-md-6">
        <div class="row">
          <div class="col-md-12">
            <div class="form-group count-container">
              <label>{'End After'|i18n('ocevents/attribute')}</label>
              <input class="form-control count" type="number" min="0" name="count" value="30">
              <div class="inline-form-text end-after-text">{'occurance(s)'|i18n('ocevents/attribute')}</div>
            </div>

            <div class="form-group unti-container">
              <div class="input-group">
                <input type="text" class="form-control ocevents-calendar" name="until">
                <div class="input-group-addon">
                  <span class="glyphicon glyphicon-calendar"></span>
                </div>
              </div>
            </div>
          </div>
        </div>*}
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
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
            aria-hidden="true">&times;</span>
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
</div>


{ezscript_require(array(
'ezjsc::jquery',
'ezjsc::jqueryUI',
'bootstrap.min.js',
'moment-with-locales.min.js',
'rrule.js',
'fullcalendar/fullcalendar.min.js',
'fullcalendar/locale/it.js',
'bootstrap-datetimepicker.min.js',
'jquery.ocevent.js'
))}


<script>
  {literal}
  $(document).ready(function () {

    var calendar = $('#calendar');
    var modal = $('.modal');
    moment().locale('it');

    // Calendar
    calendar.fullCalendar({
      locale: 'it',
      defaultDate: {/literal}{if is_set($content.events[0])}moment('{$content.events[0].start}')
      {else}moment(){/if}{/literal},
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
    $(".ocevents-calendar, #starts-at, #ends-at").datetimepicker({
      locale: 'it',
      format: 'L'
    });
  });

  var ocevent = $.ocevent;
  ocevent.init({
    'attributeId': '{/literal}{$attribute.id}{literal}'
  });

  {/literal}
</script>


