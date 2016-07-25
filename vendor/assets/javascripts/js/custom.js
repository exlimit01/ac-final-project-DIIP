/* Write here your custom javascript codes */

jQuery(document).ready(function() {

  function handleBootstrap() {
    /* Bootstrap Carousel */
    jQuery('.carousel').carousel({
      interval: 10000,
      pause: 'hover'
    });

    /* Tooltips */
    jQuery('.tooltips').tooltip();
    jQuery('.tooltips-show').tooltip('show');
    jQuery('.tooltips-hide').tooltip('hide');
    jQuery('.tooltips-toggle').tooltip('toggle');
    jQuery('.tooltips-destroy').tooltip('destroy');

    /* Popovers */
    jQuery('.popovers').popover();
    jQuery('.popovers-show').popover('show');
    jQuery('.popovers-hide').popover('hide');
    jQuery('.popovers-toggle').popover('toggle');
    jQuery('.popovers-destroy').popover('destroy');
  };



  function customCountDown () {
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
  };

  function handleHeader() {
    jQuery(window).scroll(function() {
      if (jQuery(window).scrollTop() > 100) {
      jQuery('.header-fixed .header-sticky').addClass('header-fixed-shrink');
      } else {
      jQuery('.header-fixed .header-sticky').removeClass('header-fixed-shrink');
      }
    });
  };

  // Full Screen
  var handleFullscreen = function() {
    var WindowHeight = $(window).height();
    var HeaderHeight = 0;

    if ($(document.body).hasClass("promo-padding-top")) {
      HeaderHeight = $(".header").height();
    } else {
      HeaderHeight = 0;
    }

    $(".fullheight").css("height", WindowHeight - HeaderHeight);

    $(window).resize(function() {
      var WindowHeight = $(window).height();
      $(".fullheight").css("height", WindowHeight - HeaderHeight);
    });
  }

  // Align Middle
  var handleValignMiddle = function() {
    $(".valign__middle").each(function() {
      $(this).css("padding-top", $(this).parent().height() / 2 - $(this).height() / 2);
    });
    $(window).resize(function() {
      $(".valign__middle").each(function() {
      $(this).css("padding-top", $(this).parent().height() / 2 - $(this).height() / 2);
      });
    });
  };

  customCountDown();
  handleHeader();
  handleFullscreen();
  handleValignMiddle();
  handleBootstrap();
});