$(document).ready(function() {
  /*
   * Play with this code and it'll update in the panel opposite.
   *
   * Why not try some of the options above?
   */
   var accepted_today = $("#bar-example").data("accepted_today");
   var accepted_yesterday = $("#bar-example").data("accepted_yesterday");
   var rejected_today = $("#bar-example").data("rejected_today");
   var rejected_yesterday = $("#bar-example").data("rejected_yesterday");

  Morris.Bar({
    element: 'bar-example',
    data: [
      { y: 'Accepted', a: accepted_today, b: accepted_yesterday },
      { y: 'Rejected', a: rejected_today, b: rejected_yesterday }
    ],
    xkey: 'y',
    ykeys: ['a', 'b'],
    labels: ['Actions Today', 'Actions Yesterday']
  });
});