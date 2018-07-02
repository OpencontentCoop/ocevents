<div class="tab-content u-margin-top-s">
    {if $views|contains('agenda')}
        <div id="agenda" class="tab-pane{if and($current_view, $current_view|eq('agenda'))} active{/if}"></div>
    {/if}
    {if $views|contains('list')}
        <div id="list" class="tab-pane{if and($current_view, $current_view|eq('list'))} active{/if}">
            <section id="calendar" class="service_teasers row"></section>
        </div>
    {/if}
</div>
