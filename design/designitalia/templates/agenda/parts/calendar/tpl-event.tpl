{literal}
    <script id="tpl-event" type="text/x-jsrender">
        <div class="Grid-cell u-sizeFull u-md-size1of2 u-lg-size1of3 u-padding-bottom-xs u-padding-top-xs">
            <div class="openpa-panel event">
              {{if ~mainImageUrl(data)}}
              <div class="service_photo">
                  <figure style="background-image:url({{:~mainImageUrl(data)}})"></figure>
              </div>
              {{/if}}
              <div class="openpa-panel-content">
                    <time class="event-date" datetime="{{:~formatDate(~i18n(data,'from_time'),'U')}}">
                    <span class="day">{{:~formatDate(~i18n(data,'from_time'),'D')}}</span>
                    <span class="month">{{:~formatDate(~i18n(data,'from_time'),'MMM')}}</span>
                    <span class="year">{{:~formatDate(~i18n(data,'from_time'),'Y')}}</span>
                </time>

                <h3 class="Card-title">
                    <a class="Card-titleLink" href="{{:~agendaUrl(metadata.mainNodeId)}}"title="{{:~i18n(data,'titolo')}}">{{:~i18n(data,'titolo')}}</a>
                </h3>

                {{if ~i18n(data,'to_time') && ~formatDate(~i18n(data,'to_time'),'Y.MM.D') !== ~formatDate(~i18n(data,'from_time'),'Y.MM.D')}}
                    <div class="place">
                        <i class="fa fa-calendar"></i> {{:~formatDate(~i18n(data,'from_time'),'D MMMM')}} - {{:~formatDate(~i18n(data,'to_time'),'D MMMM')}}
                    </div>
                {{/if}}

                {{if ~i18n(data,'abstract')}}
                <div class="Card-text">
                  {{:~i18n(data,'abstract')}}
                  </div>
                {{/if}}

               <div class="place">
                {{if ~i18n(data,'luogo')}}
                  <p><i class="fa fa-map-marker" aria-hidden="true"></i> {{for ~i18n(data,'luogo')}}{{>~i18n(name)}}{{/for}}</p>
                {{else}}
                  {{if ~i18n(data,'luogo_svolgimento')}}
                    <p><i class="fa fa-map-marker" aria-hidden="true"></i> {{:~i18n(data,'luogo_svolgimento')}}</p>
                  {{/if}}
                {{/if}}
              </div>

              </div>
            </div>
        </div>
    </script>
{/literal}
