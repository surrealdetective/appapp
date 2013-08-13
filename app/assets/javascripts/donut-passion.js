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
        {label: "1-Apathetic", value: passion_one},
        {label: "2-Average Joe", value: passion_two},
        {label: "3-Enthused", value: passion_three},
        {label: "4-Most Avid in the Room", value: passion_four},
        {label: "5-SuperHuman", value: passion_five}
      ]
    });
  }
});