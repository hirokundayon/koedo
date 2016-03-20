#! ruby -Ku

require 'selenium-webdriver'

class  PageObject
  def initialize(driver) 
    @driver = driver
  end

  # 部品探索&待機
  # リンクテキスト
  def waiting_element_by_link_text(リンクテキスト)
    wait = Selenium::WebDriver::Wait.new(:timeout => 100) # seconds
    wait.until {
      @driver.find_element(:link_text => リンクテキスト) }
    element =
      @driver.find_element(:link_text => リンクテキスト)
    wait.until { element.enabled? }
    return element
  end

  # name
  def Waiting_Nane(name)
    wait = Selenium::WebDriver::Wait.new(:timeout => 100) # seconds
    wait.until {
      @driver.find_element(:name => name) }
    element =
      @driver.find_element(:name => name)
    wait.until { element.enabled? }
    return element
  end

  # xpath
  def waiting_element_by_xpath(xpath)
    wait = Selenium::WebDriver::Wait.new(:timeout => 100) # seconds
    wait.until {
      @driver.find_element(:xpath => xpath) }
    element =
      @driver.find_element(:xpath => xpath)
    wait.until { element.enabled? }
    return element
  end

  # 入力
  def input_value(element, value)
    element.clear()
    element.send_keys value
    return self
  end

  # クリック
  def click(element)
    element.click
    return self
  end

  # Submit
  def Submit(element)
    element.submit
    return self
  end

  # 部品探索
  def find_element_by_name(name)
    return @driver.find_element(:name => name)
  end

  # URL get
  def get(locator)
    @driver.navigate.to locator
    return self
  end
end
