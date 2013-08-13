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
        {label: "1-Dismal", value: tech_one},
        {label: "2-Average", value: tech_two},
        {label: "3-Tech Savvy", value: tech_three},
        {label: "4-Regular Einstein", value: tech_four},
        {label: "5-Superhuman", value: tech_five}
      ]
    });
  }
});