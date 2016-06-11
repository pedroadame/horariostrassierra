document.addEventListener 'page:change', ->
  componentHandler.upgradeDom()
  highlightSchedule()
  $("#file-input").bind 'change', ->
    if $("#file-input")[0].files.length > 0
      $("#upload").prop "disabled", false
    else
      $("#upload").prop "disabled", true