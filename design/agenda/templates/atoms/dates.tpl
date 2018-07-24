{def $from_year = cond( $item.data_map.recurrences.has_content, $from_time|datetime( custom, '%Y'), false() )
     $from_month = cond( $item.data_map.recurrences.has_content, $from_time|datetime( custom, '%m'), false() )
     $from_day = cond( $item.data_map.recurrences.has_content, $from_time|datetime( custom, '%j'), false() )
     $to_year = cond( $item.data_map.recurrences.has_content, $to_time|datetime( custom, '%Y'), false() )
     $to_month = cond( $item.data_map.recurrences.has_content, $to_time|datetime( custom, '%n'), false() )
     $to_day = cond( $item.data_map.recurrences.has_content, $to_time|datetime( custom, '%j'), false() )
     $same_day = false()
}

{if and( $from_year|eq( $to_year ), $from_month|eq( $to_month ), $from_day|eq( $to_day ) )}
  {set $same_day = true()}
{/if}
{* if $item.data_map.to_time.has_content|not()}
  {set $same_day = true()}
{/if*}

{if is_set($show_time)|not()}
    {def $show_time=true()}
{/if}

{if and( $same_day, $recurrences.events|count()|eq(1) )}
  {$item.data_map.from_time.content.timestamp|l10n( 'date' )}
    {if $show_time}
        {* il confronto va fatto con datetime, perchè in inglese mezzanotte è "12am" *}
        {if $from_time|datetime( 'custom', '%H:%i' )|ne(0)}
        {if $from_time|datetime( 'custom', '%H:%i' )|ne(0)}
          &middot; {'da'|i18n('agenda/event/hours')}
          {$from_time|l10n( 'shorttime' )}
          {'a'|i18n('agenda/event/hours')}
          {$to_time|l10n( 'shorttime' )}
        {else}
          &middot; {$to_time|l10n( 'shorttime' )}
        {/if}
    {/if}
  {/if}
{elseif $recurrences.events|count()|eq(1)}
	{'da'|i18n('agenda/event/days')}
  {$from_time|l10n( 'shortdate' )}
  {'a'|i18n('agenda/event/days')}
  {$to_time|l10n( 'shortdate' )}
{else}
  {'da'|i18n('agenda/event/days')}
  {$from_time|l10n( 'date' )}
  {if and( $show_time, $from_time|datetime( 'custom', '%H:%i' )|ne(0) )}
    &middot; {$from_time|l10n( 'shorttime' )}
  {/if}
  <p>
    <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#recurrences_calendar">
      <i class="fa fa-calendar-o"></i> {'Show recurrences calendar'|i18n('ocevents/attribute')}
    </a>
  </p>
{/if}

{undef}

<div id="recurrences_calendar" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
        </button>
        <h3 class="modal-title">{'Recurrences calendar'|i18n('ocevents/attribute')}</h3>
      </div>
      <div class="modal-body">
        {attribute_view_gui attribute=$node.data_map.recurrences}
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>


