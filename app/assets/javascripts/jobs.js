// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    
     $('.toggle-on').live('click', function(ev) {
        ev.preventDefault();         
      $('.can-hide').css('visibility','hidden');
      $('.toggle-on').addClass("toggle-off").removeClass("toggle-on");
     });

     $('.toggle-off').live('click', function(ev) {
        ev.preventDefault();
       $('.can-hide').css('visibility','visible');               
       $('.toggle-off').addClass("toggle-on").removeClass("toggle-off");   
      });
      
  $('.fixed-height').scrollbar();

  $('.flag-item, .unflag-item').live('click',function(ev) {
    ev.preventDefault();
    var $target = $(ev.target);
    var theId = $target.attr('data-jobid');
    $.getJSON($target.attr('href'), function(resp){
      $.flashmessage(resp.message);
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

  $('#save-search').bind('submit', function(ev) {
    ev.preventDefault();
    var action = $(this).attr('action');
    var data = $(this).serialize();
    var sentence = $('#search_job_searches_keyword_contains').val() +' near '+$('#search_job_searches_location_contains').val();
    var resultCount = $('.search-result-title span').text();

    $.getJSON(action +'?'+data, function(resp) {
      if(resp.error) {
        $.flashmessage(resp.error, {type: 'error'});
      } else {
        $.flashmessage(resp.message);
        if(!$('a[data-searchid = '+resp.newid+']').length) {
          var $li = $('<li><span class="result-count">'+resultCount+'</span><div class="search-wrapper"><a class="delete-search" data-searchid="'+resp.newid+'" href="/job_searches_user/'+resp.newid+'"></a><a href="'+location.pathname+location.search+'">'+sentence+'</a></div></li>');
          $('.saved-searches ul').prepend($li);
        }
      }
    });
  });

  $('.delete-search').live('click', function(ev) {
    ev.preventDefault();
    var $target = $(ev.target);
    var theId = $target.attr('data-jobid');
    $.getJSON($target.attr('href'), function(resp){
      $.flashmessage(resp.message);
      $target.parents('li').remove();
    });
  });
 
});

function setupMap(jobs) {

  var markers = [], tempMarker, bounds, jobLatLng, label;
  var mapCenter = new google.maps.LatLng(37.77940, -122.43988);
  var markerIcon;

  var mapOptions = {
    zoom: 10,
    mapTypeId: google.maps.MapTypeId.TERRAIN,
    center: mapCenter,
    streetViewControl: false,
    mapTypeControl: false
  };

  var gSize = new google.maps.Size('16', '21', 'px', 'px');
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  bounds = new google.maps.LatLngBounds();

  $.each(jobs, function(idx, job) {
    jobLatLng = new google.maps.LatLng(job.lat, job.lng);
    bounds.extend(jobLatLng);
    markerOrigin = new google.maps.Point(0, (idx*21));
    markerIcon = new google.maps.MarkerImage('/images/pin-sprite.png', gSize, markerOrigin);
    tempMarker = new google.maps.Marker({
          position: jobLatLng,
          map: map,
          icon: markerIcon,
          shadow: '/images/pin-shadow.png'
    });
    markers.push(tempMarker);
  });
  map.fitBounds(bounds);
}