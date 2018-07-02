<div class="agenda-views">
        <ul class="nav nav-tabs">
        {if $views|contains('agenda')}
            <li role="presentation" class="nav-tab{if and($current_view, $current_view|eq('agenda'))} active{/if}">
                <a href="#agenda" aria-controls="agenda" data-toggle="tab">
                    <i class="fa fa-calendar fa-2x" aria-hidden="true"></i> <span>{'Calendario'|i18n('agenda')}</span>
                </a>
            </li>
        {/if}
        {if $views|contains('list')}
            <li role="presentation" class="nav-tab{if and($current_view, $current_view|eq('list'))} active{/if}">
                <a href="#list" aria-controls="list" data-toggle="tab">
                    <i class="fa fa-th fa-2x" aria-hidden="true"></i> <span> {'Elenco'|i18n('agenda')}</span>
                </a>
            </li>
        {/if}
    </ul>
</div>

