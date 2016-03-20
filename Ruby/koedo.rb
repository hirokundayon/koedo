#! /usr/local/bin/ruby23 -Ku
# coding: utf-8

require 'test/unit'
require File.dirname(__FILE__) + '/Base'
require File.dirname(__FILE__) + '/Pages/GoogleHomePage'
require File.dirname(__FILE__) + '/Pages/GoogleResultPage'
require File.dirname(__FILE__) + '/Pages/ITProPage'

class TestKoedoLug < Test::Unit::TestCase

  def test_KoedoLug
    browser_test("firefox")
    #browser_test("chrome")
    #browser_test("ie")
    #browser_test("Android Chrome")
    #browser_test("Android Chrome Remote")

    #browser_test("firefox grid local")
    #browser_test("firefox grid remote")

    #browser_test("chrome grid local")
    #browser_test("chrome grid remote")

    #browser_test("ie grid local")
    #browser_test("ie grid remote")

    #browser_test("Android Chrome grid local")
    #browser_test("Android Chrome grid remote")
  end

  def browser_test(browser_name)
    koedo = Base.new(browser_name)
    if browser_name.index("Android ") == 0
	then
      GoogleHomePage.new(koedo.driver)
        .input_key("小江戸らぐ")
        .Search()
        .click_on_SMP()
        .click_picture()
    else
      GoogleHomePage.new(koedo.driver)
        .input_key("小江戸らぐ")
        .Search()
        .click_on_PC()
        .click_picture()
    end

    koedo.quit

  end
end
