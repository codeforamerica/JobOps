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

  $('.inline_form').hide();

  // Inline form handlers
  $('.add_form_button').click(function(ev){
     ev.preventDefault();
     var $wrapper = $(ev.target).parents('.ive-got-a-button-wrapper').first();
     $wrapper.find('.inline_form').show();
  });

  $('.cancel_add_skill').click(function(ev){
     ev.preventDefault();
     var $wrapper = $(ev.target).parents('.ive-got-a-button-wrapper').first();
     $('.inline_form').hide();
  });

  $('.inline_form form').submit(function(ev) {
    ev.preventDefault();
    var itemType = $(ev.target).parents('.tab_form').find('ul').attr('class');
    console.log(itemType);
    var action = $(this).attr('action');
    var data = $(this).serialize();
    var $li;
    var $that = $(this);

    var opts = {
      url: action+'.json',
      data: data,
      dataType: 'json',
      type: 'POST',
      success: function(resp) {
        //console.log(resp);
        var newObj = resp;
        if(resp.error) {
          $.flashmessage(resp.error, {type: 'error'});
        } else {
          $.flashmessage('&quot;'+resp.skill + '&quot; has been added.');
          $li = $('<li><span class="'+itemType+'_'+newObj.id+'">'+newObj.skill+'</span><a href="#">Edit</a> <a href="/skills/'+newObj.id+'" class="delete_skill_'+newObj.id+'" data-confirm="Are you sure?" data-method="delete" data-remote="true" rel="nofollow">Destroy</a></li>')
          $('ul.'+itemType).append($li);
          $that.trigger('reset').parent().hide();
        }
      }
    }
    $.ajax(opts);
  });


  $('.edit_skill_form').hide();
  $('.edit_skill').click(function(ev){
     ev.preventDefault();

     $('.edit_skill_form').show();
  });



  $('.cancel_edit_skill').click(function(ev){
     ev.preventDefault();
     $('.edit_skill_form').hide();
  });

 });