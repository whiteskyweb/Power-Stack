(function ($, Drupal) {
  Drupal.behaviors.seasideAdminToolbar = {
    attach: function (context, settings) {


      $(".toolbar-bar .toolbar-tab.left .menu-toggle").click(function () {
        if($(this).hasClass('expanded')) {
          $(".toolbar-menu-administration").fadeOut("slow");
          $(this).removeClass('expanded');
        } else {
          $(".toolbar-menu-administration").fadeIn("slow");
          $(this).addClass('expanded');
        }
      });

      $( window ).resize(function() {
        if($("body").hasClass("toolbar-horizontal") && $(".menu-toggle").not('expanded')) {
          $(".toolbar-menu-administration").fadeIn();
        } else {
          $(".toolbar-menu-administration").fadeOut();
          $(".toolbar-bar .toolbar-tab.left .menu-toggle").removeClass('expanded');
        }
      });

    }
  };
})(jQuery, Drupal);