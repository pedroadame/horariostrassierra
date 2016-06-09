document.addEventListener 'page:change', ->
  componentHandler.upgradeDom()
  highlightSchedule()