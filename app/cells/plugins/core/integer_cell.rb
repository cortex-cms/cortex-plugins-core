module Plugins
  module Core
    class IntegerCell < Plugins::Core::Cell
      def input
        render
      end
     
      private
      
      def max
        field.validations[:max] 
      end

      def min
        field.validations[:min] 
      end
      
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
        data&.[]('integer') || @options[:default_value]
      end

      def render_label
        @options[:form].label 'data[integer]', field.name, class: 'mdl-textfield__label'
      end

      def render_input
        @options[:form].number_field 'data[integer]', value: value, placeholder: @options[:placeholder]  , max: max, min: min, class: 'mdl-textfield__input'
      end

    end
  end
end
