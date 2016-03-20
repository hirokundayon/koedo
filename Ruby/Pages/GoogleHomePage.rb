#! ruby -Ku

require 'selenium-webdriver'
require File.dirname(__FILE__) + '/PageObject'
require File.dirname(__FILE__) + '/GoogleResultPage'

class GoogleHomePage < PageObject
  def initialize(browser) 
    super(browser)
    @key_text = find_element_by_name("q")
  end

  def input_key(value)
    input_value(@key_text, value)
    return self
  end

  def Search()
    Submit(@key_text)
    return GoogleResultPage.new(@driver)
  end
end

