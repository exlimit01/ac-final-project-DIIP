// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require plugins/bootstrap/js/bootstrap.min.js
//= require plugins/jquery/jquery.min.js
//= require plugins/jquery/jquery-migrate.min.js
//= require plugins/back-to-top.js
//= require plugins/smoothScroll.js
//= require plugins/circles-master/circles.js
//= require plugins/sky-forms-pro/skyforms/js/jquery-ui.min.js
//= require plugins/scrollbar/js/jquery.mCustomScrollbar.concat.min.js
//= require js/custom.js
//= require js/app.js
//= require js/plugins/datepicker.js
//= require js/plugins/circles-master.js
//= require js/plugins/style-switcher.js

<script type="text/javascript">
  jQuery(document).ready(function() {
    App.init();
    StyleSwitcher.initStyleSwitcher();
  });
</script>
