$ ->
  $("body").on "click", ".collapser", ->
    $(this).children().toggle()
    $(this).parent().find(".collapsible").slideToggle "fast"