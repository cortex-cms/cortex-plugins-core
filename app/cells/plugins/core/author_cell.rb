module Plugins
  module Core
    class AuthorCell < Plugins::Core::Cell
      def input
        render
      end

      private

      def current_user
        "#{@options[:current_user].firstname} #{@options[:current_user].lastname}"
      end

      def value
        data&.[]('author_name') || current_user
      end

      def render_label
        @options[:form].label 'data[text]', field.name, class: 'mdl-textfield__label'
      end

      def render_input
        @options[:form].text_field 'data[text]', value: value, placeholder: @options[:placeholder], class: 'mdl-textfield__input', required: required?
      end
    end
  end
end
