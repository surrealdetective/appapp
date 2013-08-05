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