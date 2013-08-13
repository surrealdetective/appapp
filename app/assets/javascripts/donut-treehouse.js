$(document).ready(function() {
  if($("#donut-treehouse").length > 0) {
    var html = $("#donut-treehouse").data("html");
    var css = $("#donut-treehouse").data("css");
    var ruby = $("#donut-treehouse").data("ruby");
    var javascript = $("#donut-treehouse").data("javascript");
    var design = $("#donut-treehouse").data("design");

    Morris.Donut({
      element: 'donut-treehouse',
      data: [
        {label: "html", value: html},
        {label: "css", value: css},
        {label: "ruby", value: ruby},
        {label: "javascript", value: javascript},
        {label: "design", value: design}
      ]
    });
  }
});