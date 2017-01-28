module Plugins
  module Core
    class ReactTestCell < Plugins::Core::Cell
      def show
        render
      end

      private

      def hello_world_props
        { name: 'Stranger' }
      end
    end
  end
end
