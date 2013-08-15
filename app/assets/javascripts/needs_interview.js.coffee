$ ->
  $(".see-my-dossier").on "click", (e) ->
    e.preventDefault()
    url = $(this).data "href"
    load_url = "#{url} #simple"
    console.log "Loading: `#{load_url}`"
    $(".interview-shower").load load_url, ->
      console.log "ok done"