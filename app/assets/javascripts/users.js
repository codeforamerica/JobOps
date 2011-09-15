$(document).ready(function() {
  // Initialize our tabs
  $('.tab_content').hide();
  $('.tab_content').first().show();

  // Bind the tab buttons to the tab panels.
  // We just read the href of the <A> and look for an element with that ID.
  // If we find the element, we display it, if not, we do nothing.
  $('ul.tabs a').click(function(ev) {
    ev.preventDefault();
    var targetClass = this.href.split('#').pop();
    var $target = $('#'+targetClass);
    if($target.length) {
      if($('.tab_content:visible').attr('id') !== targetClass) {
        $('.tab_content:visible').fadeOut(function() { $target.fadeIn() });
      }
    }
  });

  // Setup the tooltips
  $('.tool_tip').hide();
  $('form.edit_user .field').each(function(idx, div) {
    var $toolTip = $(div).find('.tool_tip');
    var $input, offset;

    if($toolTip) {

      $input = $(div).find('input');
      offset = $input.offset();

      $toolTip.css({
        position: 'absolute',
        left: (offset.left + $input.outerWidth()) + 'px',
        top: offset.top + 'px'
      });

      $input.focusin(function(ev) {
        $(this).addClass('highlight');
        $toolTip.show();
      });
      $input.focusout(function(ev) {
        $(this).removeClass('highlight');
        $toolTip.hide();
      });
    }
  });

});