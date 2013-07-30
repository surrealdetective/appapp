$ ->
  $(".collapser").on "click", ->
    $(this).parent().find(".collapsible").slideToggle "fast"