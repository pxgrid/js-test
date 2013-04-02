require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class Foo < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:8080/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_foo
    @driver.get(@base_url + "index.html")
    @driver.find_element(:css, "input[type=\"text\"]").clear
    @driver.find_element(:css, "input[type=\"text\"]").send_keys "foo"
    @driver.find_element(:css, "input[type=\"submit\"]").click
    @driver.find_element(:css, "input[type=\"checkbox\"]").click
    assert_equal "foo", @driver.find_element(:css, "li:first-child").text
    assert_equal "complete", @driver.find_element(:css, "li:first-child").attribute("class")
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert.text
  ensure
    @accept_next_alert = true
  end
end
