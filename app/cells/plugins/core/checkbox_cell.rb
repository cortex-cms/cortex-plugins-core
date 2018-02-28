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

      def checkbox_attributes
        if @options[:tree_fields][@options[:node_key]]['children'].any?
          { onclick: "TreeBranchClicked(#{ '"#nested_' + @options[:node_key] + '"' }, this)" }
        else
          {}
        end
      end

      def checkbox_input_value
        "data[values][#{@options[:node_key]}]"
      end

      def node
        @node ||= @options[:tree_fields][@options[:node_key]]
      end
    end
  end
end
