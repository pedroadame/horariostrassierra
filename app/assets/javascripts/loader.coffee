$(document).on 'page:fetch', ->
  $("#progress-bar").show()

$(document).on 'page:change', ->
  $("#progress-bar").hide()
