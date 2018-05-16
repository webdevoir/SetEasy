var initialize_calendar;
function view_check(event, element, view) {
            title = element.find('.fc-title')
            // console.log(element);
            if(view.name == "agendaWeek"){
              if (event.crews && event.crews.length > 0){
                // title.html("");
                 $.each(event.crews, function(index, value) {
                  title.append('</br>' + value );
                });
               }
               // title.css('font-size', '20px')
               console.log("week");
    
              } else if(view.name == "agendaDay"){
                if (event.crews && event.crews.length > 0){
                // title.html("");
                 $.each(event.crews, function(index, value) {
                  title.append('</br>' + value );
                });
               }
               // title.css('font-size', '40px')
               console.log("day");
        
              }
     

}
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    console.log(calendar);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/events.json',
      defaultView: 'agendaWeek',
      eventTextColor: '#fff',
       views: {
        basic: {
          // options apply to basicWeek and basicDay views
        },
        agenda: {
          // options apply to agendaWeek and agendaDay views
          //  eventRender: function(event, element) {
          //   title = element.find('.fc-title')
          //   title.html(event.crews);
          //   title.css('font-size', '50px')
          // },
        },
        week: {
          // options apply to basicWeek and agendaWeek views
      
        },
        day: {
          // options apply to basicDay and agendaDay views
        }
      },

      height: ()=>{
          console.log(screen.width);
          if(screen.width < 577) {
                var win = $(window).height()*.9;
                console.log(win);
               return win
            } else {
                var win = $(window).height()*0.83;
                console.log(win);
               return win
            }
      },
      eventRender: function(event, element, view) {
            
             view_check(event, element, view)
           
          },

      select: function(start, end) {
        $.getScript('/events/new', function() {
          $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
          $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });

        calendar.fullCalendar('unselect');
        // calendar.fullCalendar('eventRender');
      },

      eventDrop: function(event, delta, revertFunc, view) {
        event_data = { 
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH',
            // success: function (data) {// success callback function
            //      calendar.fullCalendar('eventRender');
            // }
        });
        
      },
      
      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {
          $('#event_date_range').val(moment(event.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
          $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
        });
      }
    });
  })
};