// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('.fixed-height').scrollbar();

  $('.flag-item, .unflag-item').live('click',function(ev) {
    ev.preventDefault();
    var $target = $(ev.target);
    var theId = $target.attr('data-jobid');

    $.getJSON($target.attr('href'), function(resp){
      if($target.hasClass('flag-item')) {
        $target.removeClass('flag-item').addClass('unflag-item');
        $('.flagged-jobs ul').prepend($('<li id="flagged-job-'+theId+'"><a class="unflag-item" data-jobid="'+theId+'" href="/jobs/flag/'+theId+'"></a><a href="/jobs/'+theId+'">'+$target.next().text()+'</a></li>'));
      } else {
        $('.job-listing a[data-jobid="'+theId+'"]').removeClass('unflag-item').addClass('flag-item');
        $('#flagged-job-'+theId).fadeOut().remove();
      }
      $('.fixed-height').scrollbar('repaint');
    });
  });

  var mapCenter = new google.maps.LatLng(37.77940, -122.43988);
  var mapOptions = {
    zoom: 10,
    mapTypeId: google.maps.MapTypeId.TERRAIN,
    center: mapCenter,
    streetViewControl: false,
    mapTypeControl: false
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
});