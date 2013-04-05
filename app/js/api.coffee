clientId = -> '655945253994-7o4i08plnq0d6uv6nqv2n7b0bhap47tu.apps.googleusercontent.com'
apiKey = -> 'AIzaSyAegKTII2qIwBWUsAVKWSQq1B0aQFwE0CE';
scopes = -> 'https://www.googleapis.com/auth/analytics'


window.handleClientLoad = -> 
  window.gapi.client.setApiKey(apiKey())
  window.setTimeout(checkAuth,1)

checkAuth = -> 
  window.gapi.auth.authorize({client_id: clientId(), scope: scopes(), immediate: true}, handleAuthResult)
               
handleAuthResult = (authResult) -> 
  authorizeButton = document.getElementById('authorize-button');
  if (authResult && !authResult.error)
    authorizeButton.style.visibility = 'hidden';
    makeApiCall();
  else
    authorizeButton.style.visibility = '';
    authorizeButton.onclick = handleAuthClick;

handleAuthClick = (event) ->
  gapi.auth.authorize({client_id: clientId(), scope: scopes(), immediate: false}, handleAuthResult);
  return false;

makeApiCall = -> 
    gapi.client.load('analytics', 'v3', -> 
      request = gapi.client.analytics.data.ga.get({
        'ids': 'ga:51266672',
        'dimensions' : 'ga:pagepath',
        'start-date': '2013-03-01',
        'end-date': '2013-03-15',
        'metrics': 'ga:visits',
        'sort': '-ga:visits',
      })
      request.execute((resp) ->
        visit_total =  resp.totalsForAllResults["ga:visits"]
        visits_by_page = resp.rows
        html = JST['app/templates/stats.us']
          visit_total: visit_total, 
          visits_by_page: visits_by_page,
        document.body.innerHTML += html
        $('#startdatepicker').fdatepicker({
          format: 'mm-dd-yyyy'
        });
        $('#enddatepicker').fdatepicker({
          format: 'mm-dd-yyyy'
        });
      )
    )
