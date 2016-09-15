module FieldTypes
  module Core
    class TagCell < FieldTypes::Core::Cell
      def tag_picker
        render
      end

      private

      def value
        data&.[]('tag_list') || @options[:default_value]
      end

      def render_tag_field
        @options[:form].text_field 'data[tag_list]', value: value, placeholder: @options[:placeholder], 'data-role'=>'tagsinput'
      end
    end
  end
end
