$(document).on 'click', '.js-trigger-geo', (e) ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition evaluateLocation
  else
    alert "Geolocation is not supported by this browser."

evaluateLocation = (position) ->
  location = "http://wannabetinder.dev/evaluate_location"
  $.ajax {
    type: "POST",
    data: { _method: "POST", "location[latitude]": position.coords.latitude, "location[longitude]": position.coords.longitude },
    url: location,
    error: ->
      alert "Unexpected error, see console log"
  }
  return
