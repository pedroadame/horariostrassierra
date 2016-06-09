highlightSchedule = ->
  actual = $(".hora-actual")
  actual.parent().addClass "sch-test"
  ind = actual.index()
  $("td:nth-child("+(ind+1)+")").addClass "sch-test"
  $("th:nth-child("+(ind+1)+")").addClass "sch-test"

window.highlightSchedule = highlightSchedule