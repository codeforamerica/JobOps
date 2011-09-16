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

  // Profile information validation
  $('.edit_user').ipValidate( {
    required : { //required is a class
      rule : function() {
        return $( this ).val() == '' ? false : true;
      },
      onError : function() {
        $(this).parents('.field').first().addClass('fix-me');
      },
      onValid : function() {
        $(this).parents('.field').first().removeClass('fix-me');
        $(this).focus();
      }
    },
    submitHandler : function() { return true; }
  });
 
});