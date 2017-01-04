var ckeditor_init = function() {
  $('.ckeditor').each(function() {
    var editor_id = $(this).attr('id');
    if (!CKEDITOR.instances[editor_id]) { CKEDITOR.replace(); }
  });
};

$(document).ready(ckeditor_init);
$(document).on('turbolinks:load', ckeditor_init);
