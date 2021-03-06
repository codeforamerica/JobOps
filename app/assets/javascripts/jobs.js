// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  // Setup smart filter on/off switch
  $('.toggle-on').live('click', function(ev) {
    ev.preventDefault();
    $('.hide-off').addClass("hide-on").removeClass("hide-off");
    $('.toggle-on').addClass("toggle-off").removeClass("toggle-on");
  });

  $('.toggle-off').live('click', function(ev) {
    ev.preventDefault();
    $('.hide-on').addClass("hide-off").removeClass("hide-on");
    $('input#smart_filter').val("on");
    $('.toggle-off').addClass("toggle-on").removeClass("toggle-off");
  });

  // Add a scrollbar to every fixed-height element
  $('.fixed-height').scrollbar();

  // Bind our flagging click handlers
  $('.flag-item, .unflag-item').live('click',function(ev) {
    ev.preventDefault();
    var $target = $(ev.target);
    var flagType = ($target.hasAttr('data-jobid')) ? 'job' : 'career';
    var theId = $target.attr('data-'+flagType+'id');
    var jobLink = $target.parents('li').find('.'+flagType+'-title').first().attr('href');
    $.getJSON($target.attr('href'), function(resp){
      $.flashmessage(resp.message);
      if($target.hasClass('flag-item')) {
        $(".flagged-"+flagType+"s .blank_search").hide();
        $target.removeClass('flag-item').addClass('unflag-item');
        $('.flagged-'+flagType+'s ul').prepend($('<li id="flagged-'+flagType+'-'+theId+'"><a class="unflag-item" data-'+flagType+'id="'+theId+'" href="/'+flagType+'s/flag/'+theId+'"></a><a target="_blank" href="'+jobLink+'">'+$target.next().text()+'</a></li>'));
      } else {
        $('.'+flagType+'-listing a[data-'+flagType+'id="'+theId+'"]').removeClass('unflag-item').addClass('flag-item');
        $('#flagged-'+flagType+'-'+theId).fadeOut().remove();

        // If there are no flagged jobs, show the tip
        if($('.flagged-'+flagType+'s li').length == 0) {
          $('.flagged-'+flagType+'s .fixed-height').scrollbar('unscrollbar');
          $('.flagged-'+flagType+'s .blank_search').show();
        }
      }
      if(!$('.flagged-'+flagType+'s .scoll-pane').length) {
        $('.flagged-'+flagType+'s .fixed-height').scrollbar();
      }

      $('.fixed-height').scrollbar('repaint');
    });
  });

  $('#save-search').bind('submit', function(ev) {
    ev.preventDefault();
    var action = $(this).attr('action');
    var data = $(this).serialize();
    var sentence = $('#search_job_searches_keyword_contains').val() +' near '+$('#search_job_searches_location_contains').val();
    var resultCount = $('.search-result-title span').first().text();

    $.getJSON(action +'?'+data, function(resp) {
      if(resp.error) {
        $.flashmessage(resp.error, {type: 'error'});
      } else {
        $.flashmessage(resp.message);
        $(".saved-searches .blank_search").hide();
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

      // If there are no flagged jobs, show the tip
      if($('.saved-searches li').length == 0) {
        $('.saved-searches .fixed-height').scrollbar('unscrollbar');
        $('.saved-searches .blank_search').show();
      }

      if(!$('.saved-searches .scoll-pane').length) {
        $('.saved-searches .fixed-height').scrollbar();
      }
      $('.fixed-height').scrollbar('repaint');
    });
  });

  // Bind tooltip events
  $('a.tooltip-link').click(function(ev) {
    ev.preventDefault();
    var offset = $(this).offset();
    var $tip = $(this).next('.tooltip');
    var newTop = offset.top + $(this).height();
    var newLeft = offset.left;

    if($tip.attr('class').indexOf('-tr') != -1) {
      newLeft = offset.left - $tip.width();
    }
    $tip.css({
      position: 'absolute',
      top: newTop + 'px',
      left: newLeft +'px',
      zIndex: 501
    })
    $tip.toggle();
  });

  $('a.tooltip-close').click(function(ev) {
    ev.preventDefault();
    $(this).parents('.tooltip').hide();
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
    if(job.lat && job.lng) {
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
    }
  });

  // If there is nothing on the map, just show a map of the continental US
  if(markers.length == 0) {
    map.setCenter(new google.maps.LatLng(40.58058466412761, -98.0859375));
    map.setZoom(3);
  } else {
    map.fitBounds(bounds);
  }
}

// This is a quick plugin to determine if an object has an attribute
// http://stackoverflow.com/questions/1318076/jquery-hasattr-checking-to-see-if-there-is-an-attribute-on-an-element
$.fn.hasAttr = function(name) {  
   return this.attr(name) !== undefined;
};