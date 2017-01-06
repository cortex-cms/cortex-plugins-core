(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('cortex_media_insert', {
    requires: 'widget',
    init: function (editor) {
      editor.widgets.add('media', {
        template: '<media><img></media>',
        data: function () {
          var image_element = this.element.getFirst(),
            alt_text = this.data.alt || this.data.title,
            width = this.data.width || this.element.getAttribute('width'),
            height = this.data.height || this.element.getAttribute('height'),
            style = this.data.style || this.element.getAttribute('style'),
            className = this.data.class || this.element.getAttribute('class');

          if (this.data.id) {
            this.element.setAttribute('id', this.data.id);
            image_element.setAttribute('src', this.data.image_source);
            image_element.setAttribute('alt', alt_text);
          }
          if (width) image_element.setAttribute('width', width);
          if (height) image_element.setAttribute('height', height);
          if (style) image_element.setAttribute('style', style);
          if (className) image_element.setAttribute('class', className);
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
