$(document).ready(function() {
  /*
   * Play with this code and it'll update in the panel opposite.
   *
   * Why not try some of the options above?
  */


  if($("#bar-example").length > 0) {
    var viewed_today = $("#bar-example").data("viewed_today");
    var viewed_yesterday = $("#bar-example").data("viewed_yesterday");

    var reviewed_today = $("#bar-example").data("reviewed_today");
    var reviewed_yesterday = $("#bar-example").data("reviewed_yesterday");

    var interviewed_today = $("#bar-example").data("interviewed_today");
    var interviewed_yesterday = $("#bar-example").data("interviewed_yesterday");

    var resolved_today = $("#bar-example").data("resolved_today");
    var resolved_yesterday = $("#bar-example").data("resolved_yesterday");

    Morris.Bar({
      element: 'bar-example',
      data: [
        { y: 'Viewed', a: viewed_today, b: viewed_yesterday },
        { y: 'Reviewed', a: reviewed_today, b: reviewed_yesterday },
        { y: 'Interviewed', a: interviewed_today, b: interviewed_yesterday },
        { y: 'Resolved', a: resolved_today, b: resolved_yesterday }
      ],
      xkey: 'y',
      ykeys: ['a', 'b'],
      labels: ['Actions Today', 'Actions Yesterday']
    });
  }

});