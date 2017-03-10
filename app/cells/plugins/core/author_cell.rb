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
    end
  end
end
