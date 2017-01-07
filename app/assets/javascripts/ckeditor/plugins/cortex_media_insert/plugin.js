(function (global) {
  'use strict';

  global.CKEDITOR.plugins.add('cortex_media_insert', {
    requires: 'widget',
    init: function (editor) {
      editor.widgets.add('media', {
        template: '<media></media>',
        data: function () {
          if (this.data.id) {
            var child_element,
              alt_text = this.data.alt || this.data.title,
              width = this.data.width || this.element.getAttribute('width'),
              height = this.data.height || this.element.getAttribute('height'),
              style = this.data.style || this.element.getAttribute('style'),
              className = this.data.class || this.element.getAttribute('class');

            if (this.data.asset_type === 'image') {
              child_element = this.element.findOne('img') || new CKEDITOR.dom.element('img');

              if (this.data.id) {
                this.element.setAttribute('id', this.data.id);
                child_element.setAttribute('src', this.data.url);
                child_element.setAttribute('alt', alt_text);
              }

              if (width) child_element.setAttribute('width', width);
              if (height) child_element.setAttribute('height', height);
              if (style) child_element.setAttribute('style', style);
              if (className) child_element.setAttribute('class', className);
            } else {
              child_element = this.element.findOne('a') || new CKEDITOR.dom.element('a');

              if (this.data.id) {
                this.element.setAttribute('id', this.data.id);
                child_element.setAttribute('href', this.data.url);
                child_element.setText(alt_text)
              }
            }

            this.element.append(child_element);
          }
        },
        requiredContent: 'media',
        upcast: function (element) {
          return element.name === 'media';
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
