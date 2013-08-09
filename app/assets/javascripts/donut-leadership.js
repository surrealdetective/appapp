$(document).ready(function() {
  if($("#donut-leadership").length > 0) {
    var leadership_one = $("#donut-leadership").data("leadership_one");
    var leadership_two = $("#donut-leadership").data("leadership_two");
    var leadership_three = $("#donut-leadership").data("leadership_three");
    var leadership_four = $("#donut-leadership").data("leadership_four");
    var leadership_five = $("#donut-leadership").data("leadership_five");

    Morris.Donut({
      element: 'donut-leadership',
      data: [
        {label: "Score 1", value: leadership_one},
        {label: "Score 2", value: leadership_two},
        {label: "Score 3", value: leadership_three},
        {label: "Score 4", value: leadership_four},
        {label: "Score 5", value: leadership_five}
      ]
    });
  }
});