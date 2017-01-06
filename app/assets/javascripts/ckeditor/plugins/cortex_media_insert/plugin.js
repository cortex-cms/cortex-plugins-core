(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('cortex_media_insert', {
    requires: 'widget',
    init: function (editor) {
      editor.widgets.add('media', {
        template: '<media></media>',
        data: function () {
          if (this.data.id) {
            this.element.setAttribute('id', this.data.id);
            var child_element,
              alt_text = this.data.alt || this.data.title;

            if (this.data.asset_type === 'image') {
              child_element = new CKEDITOR.dom.element('img');

              child_element.setAttribute('src', this.data.url);
              child_element.setAttribute('alt', alt_text);
            } else {
              child_element = new CKEDITOR.dom.element('a');

              child_element.setAttribute('href', this.data.url);
              child_element.setText(alt_text)
            }

            this.element.append(child_element);
          }
        },
        requiredContent: 'media',
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
                url: media.url,
                alt: media.alt,
                asset_type: media.asset_type
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
