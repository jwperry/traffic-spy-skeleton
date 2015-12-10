require_relative '../test_helper'

class RequestValidatorTest < ControllerTestSetup

  def test_application_does_exist
    params = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    Application.create(params)

    assert RequestValidator.application_exists?(params)
  end

  def test_application_does_save
    params = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert RequestValidator.application_save?(params)
  end
#
  def test_application_does_not_save_wrong_key
    params = {identifier: "jumpstartlab", rootrl: "http://jumpstartlab.com"}

    refute RequestValidator.application_save?(params)
  end

  def test_application_does_not_save_if_missing_key
    params = {rootUrl: "http://jumpstartlab.com"}

    refute RequestValidator.application_save?(params)
  end

  def test_params_is_missing_rootUrl
    params = {'identifier' => "jumpstartlab"}

    assert RequestValidator.missing_rootUrl?(params)
  end

  def test_params_is_missing_identifier
    params = {'rootUrl' => "http://jumpstartlab.com"}

    assert RequestValidator.missing_identifier?(params)
  end

  def test_params_returns_correctly
    params = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    RequestValidator.application_save?(params)

    assert_equal "jumpstartlab",  Application.all.first[:identifier]
    assert_equal "http://jumpstartlab.com",  Application.all.first[:rootUrl]
  end
end
