$(document).ready(function() {
  
  var male_count = $("#donut-example").data("male");
  var female_count = $("#donut-example").data("female");
  var other_count = $("#donut-example").data("other");

  Morris.Donut({
    element: 'donut-example',
    data: [
      {label: "Male", value: male_count},
      {label: "Female", value: female_count},
      {label: "Other", value: other_count}
    ]
  });
  
});