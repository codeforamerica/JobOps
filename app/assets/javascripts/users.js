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

  $('.cancel_form_button').live('click', function(ev){
     ev.preventDefault();
     var $wrapper = $(ev.target).parents('.ive-got-a-button-wrapper').first();
     $('.inline_form').hide();
  });

  $('.inline_form form').submit(function(ev) {
    ev.preventDefault();
    var itemType = $(ev.target).parents('.tab_form').find('ul').attr('class');

    var action = $(this).attr('action');
    //console.log(action);
    var data = $(this).serialize();
    var $li;
    var $that = $(this);

    var opts = {
      url: action+'.json',
      data: data,
      dataType: 'json',
      type: 'POST',
      success: function(resp) {
        var newObj = resp;
        var cur_meta = window[itemType+'_meta'];
        var display_arr = [];
        if(resp.error) {
          $.flashmessage(resp.error, {type: 'error'});
        } else {
          display_arr = getDisplayArray(cur_meta, resp);
          $.flashmessage('&quot;'+display_arr[0] + '&quot; has been added.');
          $li = $('<li><div class="'+itemType+'_'+newObj.id+' display_wrapper"><span>'+display_arr.join(' ')+'</span> <a href="#" class="'+itemType+'_'+newObj.id+' edit_link">Edit</a> <a href="'+action+'/'+newObj.id+'" class="delete_link" data-confirm="Are you sure?">Destroy</a></div></li>');
          $('ul.'+itemType).append($li);
          $that.trigger('reset').parent().hide();
        }
      }
    }
    $.ajax(opts);
    return false;
  });

  $('.delete_link').live('click',function(ev) {
    ev.preventDefault();
    var itemType = $(ev.target).parents('.tab_form').find('ul').attr('class');
    var $deleteme = $(ev.target).parents('li').first();
    var opts = {
      url: $(this).attr('href')+'.json',
      dataType: 'json',
      type: 'DELETE',
      success: function(resp) {
        $.flashmessage(resp[itemType]+' has been deleted.');
        $deleteme.remove();
      }
    };

    $.ajax(opts);
  });

  $('.edit_form').hide();
  $('.edit_link').live('click', function(ev){
     ev.preventDefault();
     var $li = $(ev.target).parents('li').first();
     $li.find('.display_wrapper').hide();
     $li.find('.edit_form').show();
  });

  $('.cancel_edit_button').live('click', function(ev) {
    ev.preventDefault();
    var $li = $(ev.target).parents('li').first();
    $li.find('.display_wrapper').show();
    $li.find('.edit_form').hide();
  });

  $('.edit_form form').submit(function(ev) {
    ev.preventDefault();
    var itemType = $(ev.target).parents('.tab_form').find('ul').attr('class');

    var action = $(this).attr('action');
    //console.log(action);
    var data = $(this).serialize();
    var $li;
    var $that = $(this);

    var opts = {
      url: action+'.json',
      data: data,
      dataType: 'json',
      type: 'PUT',
      success: function(resp) {
        console.log(resp);
        var newObj = resp;
        var cur_meta = window[itemType+'_meta'];
        var display_arr = [];
        if(resp.error) {
          $.flashmessage(resp.error, {type: 'error'});
        } else {
          display_arr = getDisplayArray(cur_meta, resp);
          $.flashmessage('&quot;'+display_arr[0] + '&quot; has been updated.');
          $('.'+itemType+'_'+resp.id+' span').html(display_arr.join(' '));
          $that.trigger('reset').parent().hide();
          $that.parents('li').find('.display_wrapper').show();
        }
      }
    }
    $.ajax(opts);
    return false;
  });

  function getDisplayArray(cur_meta, resp) {
    var display_arr = [];
    $.each(cur_meta.display, function(idx, el) {
      if(el == 'date_acquired' || el == 'training_date') {
        resp[el] = resp[el].split('-').shift();
      }
      display_arr.push(resp[el]);
    });
    return display_arr;
  }

});