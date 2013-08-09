$(document).ready(function() {
  if($("#donut-tech").length > 0) {
    var tech_one = $("#donut-tech").data("tech_one");
    var tech_two = $("#donut-tech").data("tech_two");
    var tech_three = $("#donut-tech").data("tech_three");
    var tech_four = $("#donut-tech").data("tech_four");
    var tech_five = $("#donut-tech").data("tech_five");

    Morris.Donut({
      element: 'donut-tech',
      data: [
        {label: "Score 1", value: tech_one},
        {label: "Score 2", value: tech_two},
        {label: "Score 3", value: tech_three},
        {label: "Score 4", value: tech_four},
        {label: "Score 5", value: tech_five}
      ]
    });
  }
});