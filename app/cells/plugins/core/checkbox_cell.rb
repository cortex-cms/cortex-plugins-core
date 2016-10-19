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
          @options[:data]["values"].include?(node_id) ? true : false
        end
      end

      def node_id
        @options[:node]['id'].to_s
      end

      def child_identifier
        @options[:child].to_s + " " + "->"
      end

      def display_lineage
        @options[:child].to_s + " " + @options[:node]["node"]["name"]
      end
    end
  end
end
