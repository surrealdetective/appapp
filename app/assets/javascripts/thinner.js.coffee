# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#tabs div').hide();

$('#tabs div:first').show();
$('#tabs nav a:first').addClass('active');

$('#tabs a').click(function(){
    $('#tabs nav a').removeClass('active');
    $(this).addClass('active');
    var sel = $(this).attr('href');
    $('#tabs div').hide();
    $(sel).show();
});