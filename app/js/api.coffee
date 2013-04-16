clientId = -> '655945253994-7o4i08plnq0d6uv6nqv2n7b0bhap47tu.apps.googleusercontent.com'
apiKey = -> 'AIzaSyAegKTII2qIwBWUsAVKWSQq1B0aQFwE0CE';
scopes = -> 'https://www.googleapis.com/auth/analytics'

window.handleClientLoad = -> 
  window.gapi.client.setApiKey(apiKey())
  checkAuth()

checkAuth = -> 
  window.gapi.auth.authorize({client_id: clientId(), scope: scopes(), immediate: true}, handleAuthResult)
               
handleAuthResult = (authResult) -> 
  authorizeButton = document.getElementById('authorize-button');
  angular.bootstrap(document, ['blogRanking'])
  if (authResult && !authResult.error)
    authorizeButton.style.visibility = 'hidden';
  else
    authorizeButton.style.visibility = '';
    authorizeButton.onclick = handleAuthClick;


handleAuthClick = (event) ->
  gapi.auth.authorize({client_id: clientId(), scope: scopes(), immediate: false}, handleAuthResult);
  return false;
