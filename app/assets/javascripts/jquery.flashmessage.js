(function($) {
  $.flashmessage = function(msg, options) {
    var defaults = {
      target: 'body',
      id: 'flashmessage',
      timeToFade: 3000,
      type: 'notification'
    };

    var options = $.extend(defaults, options);

    var $msgBox = $('<div id="'+options.id+'"><div class="flash-wrapper '+options.type+'">'+msg+'</div></div>').css({
      position: 'fixed',
      width: '100%',
    }).hide();
    $target = (typeof options.target == 'string') ? $(options.target) : options.target;
    
    $target.prepend($msgBox);
    
    $msgBox.fadeIn().addClass('open-message').delay(options.timeToFade).fadeOut();
    
    return true;
  };
})(jQuery);