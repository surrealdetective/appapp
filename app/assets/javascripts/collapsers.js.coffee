$ ->
  $(".collapser").on "click", ->
    $(this).children().toggle()
    $(this).parent().find(".collapsible").slideToggle "fast"