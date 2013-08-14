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
        {label: "Undesirable", value: tech_one},
        {label: "Below Average", value: tech_two},
        {label: "Average", value: tech_three},
        {label: "Above Average", value: tech_four},
        {label: "Excellent", value: tech_five}
      ]
    });
  }
});