$(document).ready(function() {
  if($("#donut-leadership").length > 0) {
    var leadership = $("#donut-leadership").data("leadership");
    Morris.Donut({
      element: 'donut-leadership',
      data: [
        {label: "Undesirable", value: leadership[0]},   //score 1
        {label: "Below Average", value: leadership[1]}, //score 2
        {label: "Average", value: leadership[2]},       //score 3
        {label: "Above Average", value: leadership[3]}, //score 4
        {label: "Excellent", value: leadership[4]}      //score 5
      ]
    });
  }
});