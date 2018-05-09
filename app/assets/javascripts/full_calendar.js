var initialize_calendar;
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
      eventRender: function(event, element) {
            title = element.find('.fc-title')
            if (event.crews && event.crews.length > 0){
              title.html("");
               $.each(event.crews, function(index, value) {
                title.append('</br>' + value );
              });
             }
             console.log("evert render triggered")
            // title.html(event.crews);

            // title.css('font-size', '20px')
             
           
          },
      viewRender: function(view, element){
              if(view.name == "agendaWeek"){
                // title = $('.fc-title')
                // title.css('font-size', '20px')    
                // title.css('color', 'red')
                // test = title.css()
                console.log("agenda Week stuff triggered");  
                // console.log(test); 
                $("#customstyle").remove(); 
                var style = $('<style id="customstyle">.fc-title { font-size:20px; }</style>');
                $('html > head').append(style);   
                 
              } else if(view.name == "agendaDay"){
                $("#customstyle").remove(); 
                var style = $('<style id="customstyle">.fc-title { font-size:40px; }</style>');
                $('html > head').append(style);
              } else {
                $("#customstyle").remove();   
              }
            },
         
  




      select: function(start, end) {
        $.getScript('/events/new', function() {
          $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
          $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });

        calendar.fullCalendar('unselect');
      },

      eventDrop: function(event, delta, revertFunc) {
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
            type: 'PATCH'
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