$(document).ready(function() {
  if($("#donut-passion").length > 0) {
    // var passion_one = $("#donut-passion").data("passion_one");
    // var passion_two = $("#donut-passion").data("passion_two");
    // var passion_three = $("#donut-passion").data("passion_three");
    // var passion_four = $("#donut-passion").data("passion_four");
    // var passion_five = $("#donut-passion").data("passion_five");
    var passion = $("#donut-passion").data("passion");
    Morris.Donut({
      element: 'donut-passion',
      data: [
        {label: "Undesirable", value: passion[0]},   //score 1
        {label: "Below Average", value: passion[1]}, //score 2
        {label: "Average", value: passion[2]},       //score 3
        {label: "Above Average", value: passion[3]}, //score 4
        {label: "Excellent", value: passion[4]}      //score 5
      ]
    });
  }
});