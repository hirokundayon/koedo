#! /usr/bin/ruby -Ku
# coding: utf-8

require 'selenium-webdriver'

class Base
  def initialize(browser)
    @driver = browser(browser)
    @driver.navigate.to "http://www.google.com/"
  end

  def browser(name)
    server        = "localhost"
    server_remote = "remoteServerAddress"
    gridURL       = "http://" + server + ":4444/wd/hub"

    pathToChromedriver         = '/path/To/chromedriver/chromedriver'
    pathToIEDriverServer_x64   = '/path/To/IEDriverServer_x64/IEDriverServer_x64'
    pathToIEDriverServer_Win32 = '/path/To/IEDriverServer_Win32/IEDriverServer_Win32'

    case name
    when "firefox" then
      driver = Selenium::WebDriver.for :firefox
      driver.manage.window.maximize
    when "chrome" then
      Selenium::WebDriver::Chrome::Service.executable_path =
        File.absolute_path(pathToChromedriver)
      driver =
        Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
      driver.manage.window.maximize
    when "ie" then
      old_path = ENV['PATH']
      ENV['PATH'] = old_path + ';' + pathToIEDriverServer_Win32
      driver = Selenium::WebDriver.for :ie
      ENV['PATH'] = old_path
      driver.manage.window.maximize
    when "Android Chrome" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" =>
                                                         {"androidPackage" =>
                                                           'com.android.chrome'}
                                                         )

      driver = Selenium::WebDriver.for(:remote,
                                       :url => "http://" + server + ":9515/wd/hub",
                                       :desired_capabilities => caps)

    when "Android Chrome Remote" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" =>
                                                         {"androidPackage" =>
                                                           'com.android.chrome'}
                                                         )

      driver = Selenium::WebDriver.for(:remote,
                                       :url => "http://" + server_remote + ":9515/wd/hub",
                                       :desired_capabilities => caps)

    when "firefox grid local" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.firefox(
                                                          :version  => "43.0",
                                                          )
      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
      driver.manage.window.maximize
    when "firefox grid remote" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.firefox(
                                                          :version  =>
                                                          "43.0 remote",
                                                          )
      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
      driver.manage.window.maximize


    when "chrome grid local" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.chrome(
                                                          :version  => "47.0.2526.106 m (64-bit)",
                                                          )
      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
      driver.manage.window.maximize

    when "chrome grid remote" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.chrome(
                                                          :version  => "47.0.2526.106 m remote",
                                                          )
      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
      driver.manage.window.maximize

    when "ie grid local" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.ie(
                                                     :version  => "11.0 X64",
                                                     )
      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
      driver.manage.window.maximize

    when "ie grid remote" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.ie(
                                                     :version  => "11.0 Win32",
                                                     )
      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
      driver.manage.window.maximize

    when "Android Chrome grid local" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.chrome(
                                                         "chromeOptions" =>
                                                         {"androidPackage" => 'com.android.chrome'},
                                                         :version  => "android local"
                                                         )

      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)

    when "Android Chrome grid remote" then
      caps =
        Selenium::WebDriver::Remote::Capabilities.chrome(
                                                         "chromeOptions" =>
                                                         {"androidPackage" => 'com.android.chrome'},
                                                         :version  => "android remote"
                                                         )

      driver = Selenium::WebDriver.for(:remote,
                                       :url => gridURL,
                                       :desired_capabilities => caps)
    end
    return driver
  end

  def driver()
    return @driver
  end

  def quit()
    # 暫く待った後、終了
    sleep(10)

    @driver.quit
  end
end
