require_relative '../test_helper'
require_relative 'client_environment_simulation'

class SimulationTest < ControllerTestSetup

  def test_simulation
    ces = ClientEnvironmentSimulator.new
    ces.start_simulation
  end




end
