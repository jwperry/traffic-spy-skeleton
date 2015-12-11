require_relative '../test_helper'

class RequestValidatorTest < ControllerTestSetup

  def test_application_does_exist
    params = {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}
    Application.create(params)
    rv = RequestValidator.new(params)

    assert rv.application_exists?
  end

  def test_application_does_save
    params = {identifier: "jumpstartlab", 'rootUrl' => "http://jumpstartlab.com"}
    rv = RequestValidator.new(params)

    assert rv.application_save?
  end

  def test_application_does_not_save_wrong_key
    params = {identifier: "jumpstartlab", rootrl: "http://jumpstartlab.com"}
    rv = RequestValidator.new(params)

    refute rv.application_save?
  end

  def test_application_does_not_save_if_missing_key
    params = {rootUrl: "http://jumpstartlab.com"}
    rv = RequestValidator.new(params)

    refute rv.application_save?
  end

  def test_params_is_missing_rootUrl
    params = {'identifier' => "jumpstartlab"}
    rv = RequestValidator.new(params)

    assert rv.missing_rootUrl?
  end

  def test_params_is_missing_identifier
    params = {'rootUrl' => "http://jumpstartlab.com"}
    rv = RequestValidator.new(params)

    assert rv.missing_identifier?
  end

  def test_params_returns_correctly
    params = {identifier: "jumpstartlab", 'rootUrl' => "http://jumpstartlab.com"}
    rv = RequestValidator.new(params)
    rv.application_save?

    assert_equal "jumpstartlab",  Application.all.first[:identifier]
    assert_equal "http://jumpstartlab.com",  Application.all.first[:root_url]
  end
end
