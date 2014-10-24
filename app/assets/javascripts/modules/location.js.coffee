$(document).on 'click', '.js-trigger-find-location', (e) ->
  $("#loading").show()
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition evaluateLocation
  else
    alert "Geolocation is not supported by this browser."

$(document).on 'click', '.js-valid-location', (e) ->
  $('#user_street')[0].value = ($("#modal-location-confirmation").find('#user_street')[0].value)
  $('#user_city')[0].value = ($("#modal-location-confirmation").find('#user_city')[0].value)
  $('#user_state')[0].value = ($("#modal-location-confirmation").find('#user_state')[0].value)
  $('#user_country')[0].value = ($("#modal-location-confirmation").find('#user_country')[0].value)
  $('#user_latitude')[0].value = ($("#modal-location-confirmation").find('#user_latitude')[0].value)
  $('#user_longitude')[0].value = ($("#modal-location-confirmation").find('#user_longitude')[0].value)

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
