(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('cortex_media_insert', {
    requires: 'widget',
    init: function (editor) {
      editor.widgets.add('media', {
        template: '<media><img></media>',
        data: function () {
          if (this.data.id) {
            var image_element = this.element.getFirst(),
              alt_text = this.data.alt || this.data.title;

            this.element.setAttribute('id', this.data.id);
            image_element.setAttribute('src', this.data.image_source);
            image_element.setAttribute('alt', alt_text);
          }
        },
        requiredContent: 'media; img',
        upcast: function (element) {
          return element.name == 'media';
        }
      });

      editor.addCommand('insertMedia', {
        exec: function (editor) {
          window.MODALS.wysiwyg.open();

          global.media_select = {};
          global.media_select_defer = $.Deferred();
          global.media_select_defer.promise(global.media_select);

          global.media_select.done(function (media) {
            window.MODALS.wysiwyg.close();

            editor.execCommand('media', {
              startupData: {
                id: media.id,
                title: media.title,
                image_source: media.src,
                alt: media.alt
              }
            });
          });
        }
      });

      editor.ui.addButton('cortexMediaInsert', {
        label: 'Insert Media',
        command: 'insertMedia',
        toolbar: 'insert,0',
        icon: 'image'
      });
    }
  });
}(this));
