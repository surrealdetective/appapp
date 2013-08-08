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
        {label: "Score 1", value: passion_one},
        {label: "Score 2", value: passion_two},
        {label: "Score 3", value: passion_three},
        {label: "Score 4", value: passion_four},
        {label: "Score 5", value: passion_five}
      ]
    });
  }
});