module Plugins
  module Core
    class CheckboxCell < Plugins::Core::Cell
      def checkbox
        render
      end

      private

      def value
        if @options[:data].blank?
          false
        else
          @options[:data]["values"].include?(@options[:node_key])
        end
      end

      def checkbox_input_value
        "data[values][#{@options[:node_key]}]"
      end

      def node
        @node ||= @options[:tree_fields][@options[:node_key]]
      end

      def child_identifier
        @options[:node]['name']
      end

      def display_lineage
        #@options[:child].to_s + " " + @options[:node]["node"]["name"]
        @options[:node]['name']
      end
    end
  end
end
