var ready = function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'));
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
