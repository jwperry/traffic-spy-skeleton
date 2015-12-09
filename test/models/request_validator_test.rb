require_relative '../test_helper'

class RequestValidatorTest < ControllerTestSetup

  def test_application_does_exist
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'

    params = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert RequestValidator.application_exists?(params)
  end

  def test_application_does_not_exist
    params = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    refute RequestValidator.application_exists?(params)
  end

  def test_application_does_save
    params = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert RequestValidator.application_save?(params)
  end

  def test_application_does_not_save_wrong_key
    params = {identifier: "jumpstartlab", rootrl: "http://jumpstartlab.com"}

    refute RequestValidator.application_save?(params)
  end

  def test_application_does_not_save_if_missing_key
    params = {rootUrl: "http://jumpstartlab.com"}

    refute RequestValidator.application_save?(params)
  end

  def test_params_is_missing_root_url
    params = {'identifier' => "jumpstartlab"}

    assert RequestValidator.missing_root_url?(params)
  end

  def test_params_is_missing_identifier
    params = {'rootUrl' => "http://jumpstartlab.com"}

    assert RequestValidator.missing_identifier?(params)
  end


end
