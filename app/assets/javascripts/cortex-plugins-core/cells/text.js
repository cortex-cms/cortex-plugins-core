(function (global) {
  'use strict';

  $('.media-select--wysiwyg').on("click", function (event) {
    event.preventDefault();
    var element = $(this),
      id = element.data().id,
      title = element.data().title,
      url = element.data().url,
      alt = element.data().alt,
      asset_type = element.data().assetType;

    media_select_defer.resolve({id: id, title: title, url: url, alt: alt, asset_type: asset_type});
  });
}(this));
