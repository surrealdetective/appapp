$(document).ready(function() {

  $("a.fancybox").click(function() {
    $.fancybox({
      'padding'   : 0,
      'autoScale'   : false,
      'transitionIn'  : 'elastic',
      'transitionOut' : 'none',
      'title'     : this.title,
      'width'     : 640,
      'height'    : 385,
      'type'      : 'iframe',
      'swf'     : {
      'wmode'       : 'transparent',
      'allowfullscreen' : 'true'
      }
    });

    return false;
  });
});