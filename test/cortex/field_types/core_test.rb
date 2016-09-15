require 'test_helper'

class Cortex::FieldTypes::Core::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Cortex::FieldTypes::Core
  end
end
