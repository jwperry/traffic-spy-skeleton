require_relative '../test_helper'

class ApplicationDetailsTest < ControllerTestSetup
  # SHOTGUN Test

  def setup
    `test/test.sh`
  end

  def test_table_contains_a_full_url
    setup
    assert_equal "lol", ApplicationDetails.get_full_path_frequencies("google")
  end


end
