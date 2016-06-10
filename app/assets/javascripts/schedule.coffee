highlightSchedule = ->
  actual = $(".hora-actual")
  actual.parent().addClass "resaltado"
  ind = actual.index()
  $("td:nth-child("+(ind+1)+")").addClass "resaltado"
  $("th:nth-child("+(ind+1)+")").addClass "resaltado"

window.highlightSchedule = highlightSchedule