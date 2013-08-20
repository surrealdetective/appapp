$(document).ready(function() {
  if($("#donut-tech").length > 0) {
    var tech = $("#donut-tech").data("tech");

    Morris.Donut({
      element: 'donut-tech',
      data: [
        {label: "Undesirable", value: tech[0]},   //score 1
        {label: "Below Average", value: tech[1]}, //score 2
        {label: "Average", value: tech[2]},       //score 3
        {label: "Above Average", value: tech[3]}, //score 4
        {label: "Excellent", value: tech[4]}      //score 5
      ]
    });
  }
});