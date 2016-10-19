require 'test_helper'

class Cortex::Plugins::Core::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Cortex::Plugins::Core
  end
end
