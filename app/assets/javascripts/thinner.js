$('.show').on('click', function() {
  $(this).parent().parent().prev().show();
  $(this).parent().parent().prev().prev().show();
});

$('.cover, .modal').on('click', function() {
  $(this).next().hide();
  $(this).hide();
});