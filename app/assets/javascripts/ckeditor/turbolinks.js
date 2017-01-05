var ckeditor_init = function() {
  $('.wysiwyg_ckeditor').each(function() {
    var editor_id = $(this).attr('id');

    CKEDITOR.replace(editor_id, {
      customConfig: '/assets/ckeditor/config.js'
    });
  });
};

$(document).ready(ckeditor_init);
$(document).on('turbolinks:load', ckeditor_init);
