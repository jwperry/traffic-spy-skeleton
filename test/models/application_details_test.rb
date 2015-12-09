require_relative '../test_helper'
require_relative '../simulation_environment/client_environment_simulation'

class ApplicationDetailsTest < ControllerTestSetup

  def setup
    ces = ClientEnvironmentSimulator.new
    @ad = ApplicationDetails.new
    ces.start_simulation
  end

  def test_table_contains_a_full_url
    assert_equal "lol", @ad.get_full_path_frequencies("google")
  end


end
