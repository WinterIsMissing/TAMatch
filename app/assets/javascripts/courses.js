jQuery(function($) {
  if ($('#table_body_id').length > 0) {
    table_width = $('#table_body_id').width();
    cells = $('.table').find('tr')[0].cells.length;
    desired_width = table_width / cells + 'px';
    $('.table td').css('width', desired_width);
  }

  $('#table_body_id').sortable({
    axis: 'y',
    cursor: 'move',
    containment: '.table-responsive',
    sort: function(e, ui) {
      ui.item.addClass('active-item-shadow');
    },
    stop: function(e, ui) {
      ui.item.removeClass('active-item-shadow');
      ui.item.children('td').effect('highlight', {}, 1000);
    },
    update: function(event, ui) {
      var all_row_ids = $(this).sortable('toArray', { attribute: 'table_row_id' });
      $.ajax({
        url: 'courses/sort',
        method: 'POST',
        data: {
          ids: all_row_ids
        },
        success: function(){
          $('#table_body_id > tr').each(function(i, tr) {
            $('.index:first', this).html(i + 1);
          });

          console.log("success");
        }
      });
    }
  });
});