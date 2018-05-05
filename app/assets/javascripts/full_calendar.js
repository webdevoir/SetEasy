var initialize_calendar;
initialize_calendar = function() {
  console.log("calendar initialized from file");
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({  })

    });
  }