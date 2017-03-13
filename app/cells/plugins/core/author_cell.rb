module Plugins
  module Core
    class AuthorCell < Plugins::Core::Cell
      include Devise::Controllers::Helpers

      def input
        render
      end

      private

      def value
        data&.[]('author_name') || current_user.fullname
      end

      def render_label
        @options[:form].label 'data[author_name]', field.name, class: 'mdl-textfield__label'
      end

      def render_input
        @options[:form].text_field 'data[author_name]', value: value, placeholder: @options[:placeholder], class: 'mdl-textfield__input', required: required?
      end

      def render_default_value
        @options[:form].hidden_field 'data[default_author_name]', value: current_user.fullname
      end
    end
  end
end
