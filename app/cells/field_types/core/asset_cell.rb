module FieldTypes
  module Core
    class AssetCell < FieldTypes::Core::Cell
      def input
        render
      end

      private

      def render_label
        @options[:form].label 'data[asset]', field.name
      end

      def render_input
        @options[:form].file_field 'data[asset]'
      end
    end
  end
end
