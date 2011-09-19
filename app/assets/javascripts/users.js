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
    var $that = $(this);

    var opts = {
      url: action+'.json',
      data: data,
      dataType: 'json',
      type: 'POST',
      success: function(resp) {
        //console.log(resp);
        var newObj = resp;
        var cur_meta = window[itemType+'_meta'];
        cur_meta.type = itemType;
        cur_meta.action = action;
        var displayObj = {};

        if(resp.error) {
          $.flashmessage(resp.error, {type: 'error'});
        } else {
          displayObj = getDisplayArray(cur_meta, resp);
          $.flashmessage('&quot;'+displayObj.display_text+ '&quot; has been added.');
          $('ul.'+itemType).append(displayObj.content);
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
        var msg = resp[itemType] || 'It';
        $.flashmessage(msg+' has been deleted.');
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

  $('.edit_form form').live('submit',function(ev) {
    ev.preventDefault();
    var itemType = $(ev.target).parents('.tab_form').find('ul').attr('class');

    var action = $(this).attr('action');
    //console.log(action);
    var data = $(this).serialize();
    var $that = $(this);

    var opts = {
      url: action+'.json',
      data: data,
      dataType: 'json',
      type: 'PUT',
      success: function(resp) {
        //console.log(resp);
        var newObj = resp;
        var cur_meta = window[itemType+'_meta'];
        cur_meta.type = itemType;
        cur_meta.action = action;
        var displayObj = {};

        if(resp.error) {
          $.flashmessage(resp.error, {type: 'error'});
        } else {
          displayObj = getDisplayArray(cur_meta, resp, true);
          //console.log(displayObj);
          $.flashmessage('&quot;'+displayObj.display_text + '&quot; has been updated.');
          $('.'+itemType+'_'+resp.id+'.display_wrapper').replaceWith(displayObj.content);
          $that.trigger('reset').parent().hide();
          $that.parents('li').find('.display_wrapper').show();
        }
      }
    }
    $.ajax(opts);
    return false;
  });

  function getDisplayArray(cur_meta, resp, edit) {
    edit = edit || false;
    var display_arr = [], $li, $edit_form, html='';
    var shortenTheseDates = ['date_acquired','training_date','start_date','end_date'];

    $.each(cur_meta.display, function(idx, el) {
      if(shortenTheseDates.indexOf(el) != -1) {
        if(resp[el]) {
          resp[el] = resp[el].split('-').shift();
        }
      }
      display_arr.push(resp[el]);
    });

    cur_meta.action = (edit) ? cur_meta.action : cur_meta.action+'/'+resp.id;
    switch(cur_meta.type) {
      case 'education':
        html = '<div class="'+cur_meta.type+'_'+resp.id+' display_wrapper">'+
                 '<span>'+resp.school_name+'</span> '+
                 '<span class="tab_function">'+
                   '<a class="edit_education edit_link" data="education_'+resp.id+'">Edit</a> '+
                   '<a href="/educations/'+resp.id+'" class="delete_link" data-confirm="Are you sure?">Destroy</a>'+
                 '</span><br class="clearit">'+
                 '<ul>'+
                   '<li class="dates">'+resp.start_date+' to '+resp.end_date+'</li>'+
                   '<li class="study">'+resp.degree+' in '+resp.study_field+'</li>'+
                 '</ul>'+
               '</div>';
        $li = $(html);
        if(!edit) {
          $li = $('<li></li>').append($li);
        }
        break;
      default:
        $li = $('<div class="'+cur_meta.type+'_'+resp.id+' display_wrapper"><span>'+display_arr.join(' ')+'</span> <a href="#" class="'+cur_meta.type+'_'+resp.id+' edit_link">Edit</a> <a href="'+cur_meta.action+'" class="delete_link" data-confirm="Are you sure?">Destroy</a></div>');
        if(!edit) {
          // Clone the add-whatever form, and reset some of the vars
          $edit_form = $('ul.'+cur_meta.type).parents('.ive-got-a-button-wrapper').find('.inline_form form').clone();
          $edit_form.attr('action', $edit_form.attr('action')+'/'+resp.id);
          $edit_form.removeClass('new_'+cur_meta.type).addClass('edit_'+cur_meta.type);
          $edit_form.attr('id', 'edit_'+cur_meta.type+'_'+resp.id);
          $edit_form.append('<input name="_method" type="hidden" value="put">');
          $edit_form.find('.green-btn').attr('value','Save');
          $edit_form = $('<div class="edit_'+cur_meta.type+'_'+resp.id+' edit_form"></div>').append($edit_form);
          $edit_form.hide();
          $li = $('<li></li>').append($li).append($edit_form);
        }
    }

    return { display_text: display_arr[0], content: $li };
  }

});