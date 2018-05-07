var date_range_picker;
date_range_picker = function() {
  $('.date-range-picker').each(function(){
    $(this).click(function(){
      console.log("daterangepicker clicked");
    });
    $(this).daterangepicker({
        timePicker: true,
        timePickerIncrement: 30,
        alwaysShowCalendars: true
    }, function(start, end, label) {
      $('.start_hidden').val(start.format('YYYY-MM-DD HH:mm'));
      $('.end_hidden').val(end.format('YYYY-MM-DD HH:mm'));
    });
  })
};

// $(function() {

//     date_range_picker();
//     console.log("date picker initialized from js file");

    
//   });