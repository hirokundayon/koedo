#! ruby -Ku
# coding: utf-8

require 'selenium-webdriver'
require File.dirname(__FILE__) + '/PageObject'
require File.dirname(__FILE__) + '/ITProPage'

class GoogleResultPage < PageObject
  def initialize(driver) 
    super(driver)
    linkTextTitle =
            "小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会 - ITpro"
    #@link = waiting_element_by_link_text(linkTextTitle)
    @link = waiting_element_by_xpath("//a[@href='http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/']")
  end

  def click_on_PC()
    click(@link)
    return ITProPage.new(@driver)
  end

  def click_on_SMP()
    click(@link)
    return ITProPage.new(@driver).wait_for_PC_button().click_PC_button()
  end
end
