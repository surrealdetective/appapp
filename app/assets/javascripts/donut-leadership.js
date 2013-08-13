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
        {label: "1-Abysmal", value: leadership_one},
        {label: "2-Avg Joe", value: leadership_two},
        {label: "3-Organized", value: leadership_three},
        {label: "4-Natural Born Ldr", value: leadership_four},
        {label: "5-Superhuman", value: leadership_five}
      ]
    });
  }
});