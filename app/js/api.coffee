window.clientId = -> '655945253994-7o4i08plnq0d6uv6nqv2n7b0bhap47tu.apps.googleusercontent.com'
window.apiKey = -> 'AIzaSyAegKTII2qIwBWUsAVKWSQq1B0aQFwE0CE';
window.scopes = -> 'https://www.googleapis.com/auth/analytics'
window.client_url = -> 'https://apis.google.com/js/client.js?onload=handleClientLoad'

window.helloText = -> 'Blog Stats'

window.handleClientLoad = -> 
  alert "HI"
  
window.stats = ->
  html = JST['app/templates/stats.us'](text: helloText())
  document.body.innerHTML += html

if window.addEventListener
  window.addEventListener('DOMContentLoaded', stats, false)
else
  window.attachEvent('load', stats)

