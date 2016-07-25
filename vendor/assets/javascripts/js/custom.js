/* Write here your custom javascript codes */

$(function(){

  var note = $('#note');
  var t_now = new Date().getTime();
  var t_target = new Date(2016, 7, 5, 0, 0, 0);
  var t_diff;

  if(t_target > t_now){
    t_diff = t_target - t_now;
  }
  var ts = t_now + t_diff;

  $('#countdown').countdown({
    timestamp : ts,
    callback  : function(days, hours, minutes, seconds){

      var message = "";

      message += days + " 天" + ( days==1 ? '':'' ) + ", ";
      message += hours + " 時" + ( hours==1 ? '':'' ) + ", ";
      message += minutes + " 分" + ( minutes==1 ? '':'' ) + "  ";
      message += seconds + " 秒" + ( seconds==1 ? '':'' ) + " <br />";

      note.html(message);
    }
  });
});