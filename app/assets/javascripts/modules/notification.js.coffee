$ ->
  window.faye = new Faye.Client("http://localhost:9292/faye")
  window.faye.subscribe "/messages/new", (data) ->
    eval data
    return

  return
