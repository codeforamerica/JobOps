// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('.fixed-height').scrollbar();

  $('.flag-item, .unflag-item').click(function(ev) {
    ev.preventDefault();
    var $target = $(ev.target);
    var theId = $target.attr('data-jobid');

    console.log(ev.target);
    $.getJSON($target.attr('href'), function(resp){
      if($target.hasClass('flag-item')) {
        $target.removeClass('flag-item').addClass('unflag-item');
        $('.flagged-jobs ul').append($('<li id="flagged-job-'+theId+'"><span class="unflag-item"><a href="/jobs/flag/'+theId+'"></a></span><a href="/jobs/'+theId+'">'+$target.next().text()+'</a></li>'));
      } else {
        $target.removeClass('unflag-item').addClass('flag-item');
        $('#flagged-job-'+theId).fadeOut().remove();
      }
      $('.fixed-height').scrollbar('repaint');
    });
  });
});