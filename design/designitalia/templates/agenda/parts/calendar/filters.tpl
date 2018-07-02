{literal}
  <style>
    .agenda-filters li {
      margin-top: 12px;
      margin-right: 16px;
      background-color: #fff;
      padding: 8px 16px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }

    .agenda-filters li.active {
      background-color: #ddd;
    }
  </style>
{/literal}




<div class="Grid Grid--withGutter">
  <div class="Grid-cell u-sizeFull widget agenda-filters" data-filter="q" style="display: none">
      <div class="input-group">
          <input type="text" class="form-control" placeholder="Cerca nel titolo o nel testo" name="srch-term"
                 id="srch-term">
          <div class="input-group-btn">
              <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i>
              </button>
          </div>
      </div>
  </div>

  <div class="Grid-cell u-sizeFull u-margin-all-s widget agenda-filters {if $current_view|eq('agenda')}hide{/if}" data-filter="date">
      <h4>{'Quando?'|i18n('agenda')}</h4>
      <ul class="u-sm-flexInline u-md-flexInline u-lg-flexInline">
          <li><a href="#" data-value="today">{'Oggi'|i18n('agenda')}</a></li>
          <li><a href="#" data-value="weekend">{'Questo fine settimana'|i18n('agenda')}</a></li>
          <li class="active"><a href="#" data-value="month">{'Questo mese'|i18n('agenda')}</a></li>
          <li><a href="#" data-value="next 7 days">{'I prossimi 7 giorni'|i18n('agenda')}</a></li>
          <li><a href="#" data-value="next 30 days">{'I prossimi 30 giorni'|i18n('agenda')}</a></li>
          <li><a href="#" data-value="all">{'Tutti'|i18n('agenda')}</a></li>
      </ul>
  </div>
</div>
