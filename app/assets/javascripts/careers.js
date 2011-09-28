$(document).ready(function() {
  var industry_boxes = $('.industry-box'),
      boxes_per_row = 4,
      counter = 0,
      current_row = 0,
      total_rows = Math.ceil(industry_boxes.length / boxes_per_row),
      current_classes;

  var there_are_orphans = (industry_boxes.length % boxes_per_row !== 0)

  $.each(industry_boxes, function(idx, el) {
    current_classes = [];

    if(there_are_orphans && current_row === (total_rows -1)) {
      current_classes.push('orphan');
    }

    if(counter % boxes_per_row === 0) {
      current_classes.push('left');
    } else if(counter % boxes_per_row === (boxes_per_row - 1)) {
      current_classes.push('right');
      current_row += 1;
    } else {
      if(current_row === 0 || current_row === (total_rows -1)) {
        current_classes.push('middle');
      } else {
        current_classes.push('center');
      }
    }


    $(el).addClass(current_classes.join(' '));
    counter += 1;
  });

});