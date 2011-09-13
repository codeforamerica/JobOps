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

  $('#save-search').bind('submit', function(ev) {
    ev.preventDefault();
    var action = $(this).attr('action');
    var data = $(this).serialize();
    var sentence = $('#keyword').val() +' near '+$('#location').val();
    var resultCount = $('.search-result-title span').text();

    $.getJSON(action +'?'+data, function(resp) {
      alert(resp.message);  // TODO: Make this a pretty alert
      if(!$('a[data-searchid = '+resp.newid+']').length) {
        var $li = $('<li><span class="result-count">'+resultCount+'</span><a class="delete-search" data-searchid="'+resp.newid+'" href="/job_searches_user/'+resp.newid+'">X</a><a href="'+location.pathname+location.search+'">'+sentence+'</a></li>');
        $('.saved-searches ul').prepend($li);
      }
    });
  });

  $('.delete-search').live('click', function(ev) {
    ev.preventDefault();
    var $target = $(ev.target);
    var theId = $target.attr('data-jobid');
    $.getJSON($target.attr('href'), function(resp){
      alert(resp.message);
      $target.parent().remove();
    });
  });

  var fakeJobs = [
    { lat: 37.774929, lng: -122.419415 },
    { lat: 37.812496, lng: -122.287445 },
    { lat: 37.758772, lng: -122.388381 },
    { lat: 37.744114, lng: -122.439880 },
    { lat: 37.797305, lng: -122.459793 },
    { lat: 37.855880, lng: -122.481765 },
    { lat: 37.661537, lng: -122.394561 },
    { lat: 37.664255, lng: -122.089004 },
    { lat: 37.777227, lng: -121.970214 },
    { lat: 37.937157, lng: -122.048492 }
  ];

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
            shadow: 'images/pin-shadow.png'
      });

      markers.push(tempMarker);
    });
    map.fitBounds(bounds);
  }

  setupMap(fakeJobs);
});