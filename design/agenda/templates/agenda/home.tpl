{def $node = agenda_root_node()}
{def $hide_tags = $node|attribute('hide_tags').content.tag_ids
     $hide_iniziative = array()
     $hide_all_filter = false()
     $view_all = false()}
{if $node|has_attribute('hide_tags')}
    {set $hide_tags = $node|attribute('hide_tags').content.tag_ids}
{/if}
{if $node|has_attribute('hide_iniziative')}
{foreach $node|attribute('hide_iniziative').content.relation_list as $item}
  {set $hide_iniziative = $hide_iniziative|append($item.contentobject_id)}
{/foreach}
{/if}

{if $node|has_attribute('hide_all_filter')}
  {set $hide_all_filter = true()}
{/if}

{if and($hide_all_filter|not(), $node|has_attribute('view_all')) }
  {set $view_all = true()}
{/if}

{def $agenda_query_custom = array()}
{if count($hide_tags)|gt(0)}
  {foreach $hide_tags as $tag}
    {set $agenda_query_custom = $agenda_query_custom|append(concat("tipo_evento.tag_ids != '", $tag, "'"))}
  {/foreach}
{/if}
{if count($hide_iniziative)|gt(0)}
  {foreach $hide_iniziative as $iniziativa}
    {set $agenda_query_custom = $agenda_query_custom|append(concat("iniziativa.id != '", $iniziativa, "'"))}
  {/foreach}
{/if}

<section class="hgroup noborder home-agenda">

    {include uri='design:agenda/parts/home_layout.tpl'}

    {include uri='design:agenda/parts/calendar/views.tpl' views=array('list','geo','agenda') view_all=$view_all}

</section>

{include
    uri='design:agenda/parts/calendar/calendar.tpl'
    name=home_calendar
    calendar_identifier=$site_identifier
    filters=array('date', 'type', 'target', 'iniziativa', 'where', 'theme')
    base_query=concat('classes [',agenda_event_class_identifier(),'] and subtree [', calendar_node_id(), '] and state in [moderation.skipped,moderation.accepted] ', cond($agenda_query_custom|count()|gt(0), ' and ', false()), $agenda_query_custom|implode(' and '))
}

{undef $node $hide_tags $hide_iniziative $agenda_query_custom}
