module FieldTypes
  module Core
    class Cell < FieldTypeCell
      view_paths << "#{Cortex::FieldTypes::Core::Engine.root}/app/cells"
    end
  end
end
