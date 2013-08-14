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
        {label: "Undesirable", value: leadership_one},
        {label: "Below Average", value: leadership_two},
        {label: "Average", value: leadership_three},
        {label: "Above Average", value: leadership_four},
        {label: "Excellent", value: leadership_five}
      ]
    });
  }
});