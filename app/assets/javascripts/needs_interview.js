$(document).ready(function() {

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    
    $('#calendar').fullCalendar({
        header: {
            left: 'month,basicWeek,agendaDay',
            center: 'title',
            right: 'today prev,next'
        },
        height: 350,
        defaultView: 'basicWeek',
        selectable: true,
        selectHelper: true,
        editable: true,
        events: [
            
        ],
        eventBackgroundColor: '#278ccf'
    });
    
    // handler to close the new event popup just for displaying purposes
    // more documentation for fullcalendar on http://arshaw.com/fullcalendar/
    $(".popup .close-pop").click(function () {
        $(".new-event").fadeOut("fast");
    });
});