{ezcss_require(array('ocevent.css', 'fullcalendar.min.css', 'bootstrap-datetimepicker.min.css'))}

{if $attribute.has_content}
  {def $content = $attribute.content}
{/if}

<div class="ocevent-edit" id="{concat('ocevent_attribute_', $attribute.id)}">
  <div class="row">
    <div class="col-md-12">

      <div class="form-group row">
        <div class="col-md-6">
          <label for="StartDate">{'Start'|i18n('ocevents/attribute')}</label>
          <div class="input-group">
            <input type="text" class="form-control ocevent-calendar startDate" id="startDate" name="dtstart" value="{if $content.input.startDateTime}{recurrences_strtotime($content.input.startDateTime)|l10n( 'shortdatetime' )}{/if}">
            <div class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <label for="EndDate">{'End'|i18n('ocevents/attribute')}</label>
          <div class="input-group">
            <input type="text" class="form-control ocevent-calendar endDate" id="EndDate" name="dtEnd" value="{if $content.input.endDateTime}{recurrences_strtotime($content.input.endDateTime)|l10n( 'shortdatetime' )}{/if}">
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
              <option data-value="none" value="none" {if $content.input.freq|eq('none')}selected="selected"{/if}>{'None (run once)'|i18n('ocevents/attribute')}</option>
              <option data-value="daily" value="3" {if $content.input.freq|eq('3')}selected="selected"{/if}>{'Daily'|i18n('ocevents/attribute')}</option>
              <option data-value="weekly" value="2" {if $content.input.freq|eq('2')}selected="selected"{/if}>{'Weekly'|i18n('ocevents/attribute')}</option>
              <option data-value="monthly" value="1" {if $content.input.freq|eq('1')}selected="selected"{/if}>{'Monthly'|i18n('ocevents/attribute')}</option>
            </select>
          </div>
        </div>

        <div class="col-md-6">
          <div class="interval-container hide">
            <label>{'Every'|i18n('ocevents/attribute')}</label>
            <input class="form-control interval" type="number" min="1" name="interval" value="{if $content.input.interval}{$content.input.interval}{else}1{/if}">
          </div>
        </div>
      </div>

      <div class="form-group weekly-container hide">
        <label>{'Select week day'|i18n('ocevents/attribute')}</label>
        <div class="clearfix">
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="0" {if $content.input.byweekday|contains('0')}checked="checked"{/if}> {'Mon'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="1" {if $content.input.byweekday|contains('1')}checked="checked"{/if}> {'Tue'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="2" {if $content.input.byweekday|contains('2')}checked="checked"{/if}> {'Wed'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="3" {if $content.input.byweekday|contains('3')}checked="checked"{/if}> {'Thu'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="4" {if $content.input.byweekday|contains('4')}checked="checked"{/if}> {'Fri'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="5" {if $content.input.byweekday|contains('5')}checked="checked"{/if}> {'Sat'|i18n('ocevents/attribute')}
            </label>
          </div>
          <div class="checkbox pull-left">
            <label>
              <input type="checkbox" name="byweekday" value="6" {if $content.input.byweekday|contains('6')}checked="checked"{/if}>{'Sun'|i18n('ocevents/attribute')}
            </label>
          </div>
        </div>
      </div>

      <div class="form-group monthly-container hide"></div>

      <div class="form-group row untiltype-container hide">
        <div class="col-md-6">
          <label>{'End recurrence'|i18n('ocevents/attribute')}</label>
          <div class="input-group">
            <input type="text" class="form-control until ocevent-calendar" name="until" value="{if $content.input.until}{recurrences_strtotime($content.input.until)|l10n( 'shortdate' )}{/if}">
            <div class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </div>
          </div>
        </div>

        <div class="col-md-6">
            <label>{'Recurrence text'|i18n('ocevents/attribute')}</label>
            <input type="text" id="events_text" data-value="text" name="{$attribute_base}_ocevent_data_{$attribute.id}[text]"
                   class="form-control" value="{if is_set($content.text)}{$content.text}{/if}"/>
        </div>
      </div>
    </div>

  </div>


  <div class="row{if ezini('DebugSettings', 'DebugOutput')|eq('disabled')} hide{/if}">
    <div class="col-md-12">
      <input type="hidden" id="has_content" value="{$attribute.has_content}">

      <strong>Input</strong>
      <textarea id="events_input" name="{$attribute_base}_ocevent_data_{$attribute.id}[input]" rows="10" cols="50"
                class="form-control">{if is_set($content.input_json)}{$content.input_json}{/if}</textarea>

      <strong>Recurrences</strong>
      <textarea id="events_recurrences" name="{$attribute_base}_ocevent_data_{$attribute.id}[recurrences]" rows="10"
                cols="50"
                class="form-control">{if is_set($content.recurrences_json)}{$content.recurrences_json}{/if}</textarea>

      <strong>Events</strong>
      <textarea id="events" name="{$attribute_base}_ocevent_data_{$attribute.id}[events]" rows="10" cols="50"
                class="form-control">{if is_set($content.events_json)}{$content.events_json}{/if}</textarea>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div id='calendar' class="calendar"></div>
    </div>
  </div>

  <div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
              aria-hidden="true">&times;</span>
          </button>
          <h3 class="modal-title">{'Modify event'|i18n('ocevents/attribute')}</h3>
        </div>
        <div class="modal-body">
          <input type="hidden" id="title"/>
          <div class="form-group">
              <label for="starts-at">{'Start'|i18n('ocevents/attribute')}</label>
            <input type="text" class="form-control" name="starts_at" id="starts-at">
          </div>
          <div class="form-group">
              <label for="ends-at">{'End'|i18n('ocevents/attribute')}</label>
            <input type="text" class="form-control" name="ends_at" id="ends-at">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger pull-left" data-dismiss="modal" id="delete-event"><i
              class="fa fa-trash"></i> {'Delete'|i18n('ocevents/attribute')}
          </button>
          <button type="button" class="btn btn-success" data-dismiss="modal" id="save-event"><i
              class="fa fa-save"></i> {'Store'|i18n('ocevents/attribute')}
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
'moment.min.js',
'moment-with-locales.min.js',
'rrule.js',
'fullcalendar/fullcalendar.min.js',
'fullcalendar/locale/it.js',
'bootstrap-datetimepicker.min.js',
'jquery.ocevent.js'
))}


<script>
  {literal}

    var ocevent = $.ocevent;
    ocevent.init({
      'attributeId': '{/literal}{$attribute.id}{literal}',
      'endpoint': '{/literal}{'/recurrence/parse'|ezurl(no)}{literal}' ,
    });

  {/literal}
</script>


