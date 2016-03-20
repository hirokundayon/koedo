#! ruby -Ku
# -*- coding: utf-8 -*-

require 'selenium-webdriver'
require File.dirname(__FILE__) + '/PageObject'

class ITProPage < PageObject
  def initialize(driver) 
    super(driver)
  end

  def click_picture()
    picture = waiting_element_by_xpath("//img[@alt=\"小江戸らぐ\"]")
    #@driver.save_screenshot('C:\\home\\hirofumi\\koedo\\b.png')
    click(picture)
    return self
  end

  def wait_for_PC_button()
    @PC_button = waiting_element_by_xpath("//img[@src=\"/images/n/itpro/2010/leaf/btn_pc.gif\"]")
    return self
  end

  def click_PC_button()
    click(@PC_button)
    return self
  end
end
