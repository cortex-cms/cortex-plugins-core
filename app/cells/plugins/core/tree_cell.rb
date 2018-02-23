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

      def render_select
        @options[:form].select 'data[values]', metadata_values, {selected: value}
      end

      def metadata_values
        values = [["-- Select an Option --", nil]]

        # @options[:metadata]["data"]["tree_array"].map do |value|
        #   values << [value["node"]["name"], value["id"]]
        # end
        #
        # values
        @options[:metadata].keys
      end
    end
  end
end
