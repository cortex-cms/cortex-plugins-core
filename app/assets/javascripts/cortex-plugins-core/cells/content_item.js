$('.media-select--featured').click(function (elem) {
  var id = $(this).data().id;
  var title = $(this).data().title;
  var thumb_url = $(this).data().thumb;

  $(".association_content_item_id").val(id);

  $('.content-item-button__selection').remove();
  $('.content-item-button').append(
    '<div class="content-item-button__selection">' +
    '<img src="' + thumb_url + '" height="50px">' +
    '<div class="content-item-button__selection__text">' +
    'Selected Media: ' +
    title +
    '</div></div>'
  );

  window.MODALS.featured.close();
});
