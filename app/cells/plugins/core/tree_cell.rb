module Plugins
  module Core
    class TreeCell < Plugins::Core::Cell
      def checkboxes
        render
      end

      def dropdown
        render
      end

      private

      def value
        data&.[]('values') || @options[:default_value]
      end

      def tree_fields
        @tree_fields ||=  @options[:metadata]['tree_fields']
      end

      def render_select
        @options[:form].select 'data[values]', metadata_values, {selected: value}
      end

      def metadata_values
        values = [["-- Select an Option --", nil]]

        @options[:metadata]['data'].keys.map do |field_key|
          values << [@options[:metadata]['data'][field_key]['name'], field_key]
        end

        values
      end
    end
  end
end
