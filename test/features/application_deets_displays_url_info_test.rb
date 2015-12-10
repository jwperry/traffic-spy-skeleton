require_relative '../test_helper'
require_relative '../simulation_environment/client_environment_simulation'


class UserSeesUrlDataTest < FeatureTest

  def setup
    ces = ClientEnvironmentSimulator.new
    # ces = TestData.new.generate
    ces.start_simulation_test
  end

  # def simulate_matrix_neo_the_one
  #   ces = ClientEnvironmentSimulator.new
  #   ces.start_simulation_development
  # end

  def test_user_sees_url_stats
    # self.setup
    visit('/sources/google')
    within("body") do
      assert page.has_content?("google")
    end
  end

end
