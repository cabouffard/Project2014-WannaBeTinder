$(document).on 'click', '.js-deny-user', (e) ->
  $.ajax {
    type: "POST",
    data: { _method: "PATCH", "user[profession]": $(this).data("profession"), "position": $(this).data("position") },
    url: $(this).data("update-url"),
    error: ->
      alert "Unexpected error, see console log"
  }
  return

$(document).on 'click', '.js-clear-denied', (e) ->
  $.ajax {
    type: "POST",
    data: { _method: "PATCH" },
    url: $(this).data("update-url"),
    error: ->
      alert "Unexpected error, see console log"
  }
  return


# $(document).on 'click', '.js-contact-user', (e) ->

# evaluateLocation = (position) ->
#   location = "http://wannabetinder.dev/evaluate_location"
#   $.ajax {
#     type: "POST",
#     data: { _method: "POST", "location[latitude]": position.coords.latitude, "location[longitude]": position.coords.longitude },
#     url: location,
#     error: ->
#       alert "Unexpected error, see console log"
#   }
#   return
