$(document).ready(function() {
  // Account information validation
  $('.user_edit').ipValidate( {
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