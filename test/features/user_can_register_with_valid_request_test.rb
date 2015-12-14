require_relative '../test_helper'
require_relative '../simulation_environment/test_data.rb'

class UserCanRegisterWithValidRequestTest < FeatureTest

  def setup
    td = TestData.new(2)
    td.generate
  end

  def test_user_can_register_with_valid_request
      visit "/"
      assert_equal "/", current_path
      within("#main_page_heading") do
        assert page.has_content?("Traffic Spy")
      end

      visit "/sources/google"
      assert_equal "/sources/google", current_path
  end

end