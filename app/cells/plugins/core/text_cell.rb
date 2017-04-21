module Plugins
  module Core
    class TextCell < Plugins::Core::Cell
      def input
        render
      end

      def wysiwyg
        render
      end

      def multiline_input
        render
      end

      private

      def input_display
        @options[:input_options]&.[](:display)
      end

      def input_classes
        input_display&.[](:classes)
      end

      def input_styles
        input_display&.[](:styles)
      end

      def value
        data&.[]('text') || @options[:default_value]
      end

      def render_label_and_input
        render_label(:text) do
          render_input
        end
      end

      def render_label
        @options[:form].label 'data[text]', field.name, class: 'mdl-textfield__label'
      end

      def render_input
        @options[:form].text_field 'data[text]', value: value, placeholder: @options[:placeholder], class: 'mdl-textfield__input', data: { required: required? }
      end

      def render_wysiwyg
        @options[:form].text_area 'data[text]', value: value, class: "#{input_classes} wysiwyg_ckeditor", style: input_styles, data: { required: required? }
      end

      def render_multiline_input
        @options[:form].text_area 'data[text]', value: value , placeholder: @options[:placeholder], rows: input_display&.[](:rows) , class: 'mdl-textfield__input', data: { required: required? }
      end
    end
  end
end
