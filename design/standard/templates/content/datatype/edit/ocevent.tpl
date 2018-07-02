{*{def $indexInc = 0
     $indexExc = 0
     $weekdayShortNames = ezini( 'Settings', 'WeekdayShortNames', 'ezpublishevent.ini' )
     $localeVars = ocevent_locale_vars( array( 'ShortDateFormat', 'ShortTimeFormat', 'HTTPLocaleCode' ) )
     $dateFormat = $localeVars['ShortDateFormat']
     $timeFormat = $localeVars['ShortTimeFormat']}

{if ezhttp_hasvariable( concat( $attribute_base, '_ocevent_data_', $attribute.id ), 'post' )}
    {def $postData = ezhttp( concat( $attribute_base, '_ocevent_data_', $attribute.id ), 'post' )}
    {if is_set( $postData.include )}
        {def $postInclude = $postData.include}
    {/if}
    {if is_set( $postData.exclude )}
        {def $postExclude = $postData.exclude}
    {/if}
{/if}

{$content.input|attribute(show)}


<input type="hidden" class="ocevent" id="ocevent{$attribute.id}" data-attrid="{$attribute.id}" data-locale="{$localeVars['HTTPLocaleCode']|extract(0,2)}" />
<input type="hidden" value="{$localeVars['HTTPLocaleCode']|extract(0,2)}" name="{$attribute_base}_ocevent_data_{$attribute.id}[locale]" />
<input type="hidden" value="{$attribute.id}" name="oceventdate_attr_id" />*}


{if $attribute.has_content}
    {def $content = $attribute.content}
{/if}



<fieldset>
    {include uri='design:content/datatype/edit/recurrenceperiod.tpl'}
</fieldset>

