$ ->
  $(".see-my-dossier").on "click", (e) ->
    e.preventDefault()
    url = "#{$(this).data("href")} #simple"
    console.log "Loading: `#{url}`"
    $(".interview-shower").load url, ->
      console.log "ok done"