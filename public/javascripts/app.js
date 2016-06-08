$(document).ready(function() {
  $(".meetup_page").hover(
    function() {
      $(this).addClass("hover_background");
    }, function() {
      $(this).removeClass("hover_background");
    }
  );
});
