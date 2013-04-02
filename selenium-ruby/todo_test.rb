require 'test/unit'
require 'selenium-webdriver'

class TodoAppTest < Test::Unit::TestCase
  def setup
    # ドライバーにFirefoxを指定
    @driver = Selenium::WebDriver.for :firefox

    # urlを開く
    @driver.navigate.to 'http://localhost:8080/'

    # フォームをサブミットしてチェックボックスをクリック
    @driver.find_element(:css => 'input[type="text"]').send_keys 'foo'
    @driver.find_element(:css => 'form').submit
    @driver.find_element(:css => 'li input[type="checkbox"]').click
  end
 
  def teardown
    @driver.quit
  end
 
  def test_todo
    list = @driver.find_elements :css => 'li'
    item = list[0]

    # 要素の検証
    assert_equal(list.size, 1)
    assert_equal(item.text, 'foo')
    assert_equal(item.attribute('class'), 'complete')
  end
end
