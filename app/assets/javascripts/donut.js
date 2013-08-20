$(document).ready(function() {
  if($("#donut-example").length > 0) {
    var gender = $("#donut-example").data("gender");
    var male_count = $("#donut-example").data("male");
    var female_count = $("#donut-example").data("female");
    var other_count = $("#donut-example").data("other");

    Morris.Donut({
      element: 'donut-example',
      data: [
        {label: "Male", value: gender[0]}, //male
        {label: "Female", value: gender[1]}, //female
        {label: "Other", value: gender[2]} //other
      ]
    });
  }
});