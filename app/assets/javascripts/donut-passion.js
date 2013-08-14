$(document).ready(function() {
  if($("#donut-passion").length > 0) {
    var passion_one = $("#donut-passion").data("passion_one");
    var passion_two = $("#donut-passion").data("passion_two");
    var passion_three = $("#donut-passion").data("passion_three");
    var passion_four = $("#donut-passion").data("passion_four");
    var passion_five = $("#donut-passion").data("passion_five");

    Morris.Donut({
      element: 'donut-passion',
      data: [
        {label: "Undesirable", value: passion_one},
        {label: "Below Average", value: passion_two},
        {label: "Average", value: passion_three},
        {label: "Above Average", value: passion_four},
        {label: "Excellent", value: passion_five}
      ]
    });
  }
});