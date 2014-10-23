$(document).ready ->
  $(document).ajaxStart(->
    $("#loading").show()
    return
  ).ajaxStop ->
    $("#loading").hide()
    return

  return

