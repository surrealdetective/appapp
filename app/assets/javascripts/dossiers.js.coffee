# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# $(".select2").select2({
#     placeholder: "Search by status"
# })

$ ->
  updateCountdown = ->
    remaining = 140 - $(".dossier_content").val().length
    $(".countdown").text("#{remaining} characters remaining")
  if $(".dossier_content").length > 0 # if this div exists
    updateCountdown()
  $(".dossier_content").change updateCountdown
  $(".dossier_content").keyup updateCountdown

  # when you click a sorter, it will not click
  # it will really copy the name of what you clicked
  # and move it into the hidden text field of the search form
  # then submit the search form
  # this is good because previously it was forgetting the non-sort form stuff
  # now it maintains all that shit
  $(".sorter a").on "click", (e) ->
    e.preventDefault()
    which_sorter = $(this).text().toLowerCase()
    switch which_sorter
      when "name"   then $("#dossier_sort_by").val "user"
      when "status" then $("#dossier_sort_by").val "aasm_state"
    $("#dossier_search").click()

  $(".btn-group").on "click", ->
    if $(this).find(".dropdown-toggle").length is 1
      $(this).find("ul").toggle()
