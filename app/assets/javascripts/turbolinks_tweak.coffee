document.addEventListener 'page:change', ->
  componentHandler.upgradeDom()
  highlightSchedule()
  $("#file-input").bind 'change', ->
    if $("#file-input")[0].files.length > 0
      $("#upload").prop "disabled", false
    else
      $("#upload").prop "disabled", true
  $("#import-xml-form")[0].addEventListener "submit", ->
    $("#import-xml-title")[0].innerHTML = I18n[I18n.locale]["procesando"]
    $("#progress-bar").show()