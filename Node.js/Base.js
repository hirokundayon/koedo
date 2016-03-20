exports.driver = function (Web_Browser) {
  /*
   * サーバおよびURLの指定
   */
  var server_local = 'localhost';
  var server_remote = 'path.to.remote.server';
  var gridURL   = 'http://' + server_local  + ':4444/wd/hub';
  var remoteURL = 'http://' + server_remote + ':9515/wd/hub';

  var webdriver = require('selenium-webdriver'),
    SeleniumServer = require('selenium-webdriver/remote').SeleniumServer;

  /*
   * 各WebDriverの指定
   */
  var pathToSeleniumJar          = '/path/To/Selenium/Jar/selenium-server-standalone-2.53.0.jar';
  var pathToChromedriver         = '/path/to/chromedriver/chromedriver';
  var pathToIEDriverServer_x64   = '/path/to/IEDriverServer_x64';
  var pathToIEDriverServer_Win32 = '/path/to/IEDriverServer_Win32';

  var server = new SeleniumServer(pathToSeleniumJar, {
    port: 4567
  });

  /*
   * Selenium Grid を使わない場合はローカルでサーバを起動する。
   */
  if (Web_Browser.indexOf('Selenium Grid') == -1) {
    server.start();
  }

  /*
   * 各ブラウザごとのWebDriverの設定
   */
  var Web_Driver;
  switch (Web_Browser) {
    case 'Mozilla Firefox':
      Web_Driver = new webdriver.Builder().
        usingServer(server.address()).
        withCapabilities(webdriver.Capabilities.firefox()).
        build();
      break;
    case 'Google Chrome':
      var chrome  = require('selenium-webdriver/chrome');
      var service = new chrome.ServiceBuilder(pathToChromedriver).build();
      chrome.setDefaultService(service);
      Web_Driver =
        new webdriver.Builder()
          .withCapabilities(webdriver.Capabilities.chrome())
          .build();
      break;
    case 'Internet Explorer 32':
      var PATH = process.env.PATH;
      process.env.PATH = pathToIEDriverServer_Win32 + ';' + PATH;
      Web_Driver = new webdriver.Builder().
        withCapabilities(webdriver.Capabilities.ie()).
        build();
      process.env.PATH = PATH;
      break;
    case 'Internet Explorer 64':
      var PATH = process.env.PATH;
      process.env.PATH = pathToIEDriverServer_x64 + ';' + PATH;
      Web_Driver = new webdriver.Builder().
        withCapabilities(webdriver.Capabilities.ie()).
        build();
      process.env.PATH = PATH;
      break;
    case 'Android Chrome':
      var chrome  = require('selenium-webdriver/chrome');
      var service = new chrome.ServiceBuilder(pathToChromedriver).build();
      var options = new chrome.Options().androidChrome();
      Web_Driver  = new chrome.Driver(options, service);
      break;
    case 'Android Chrome Remote':
      Web_Driver = new webdriver.Builder().
        usingServer(remoteURL).
        withCapabilities({
          'chromeOptions': {
             'androidPackage': 'com.android.chrome',
             },
          'browserName': 'chrome',
        }).
        build();
      break;
    case 'Mozilla Firefox Grid local':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'browserName': 'firefox',
          'version': '38.0.1'
        }).
        build();
      break;
    case 'Mozilla Firefox Grid remote':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'browserName': 'firefox',
          'version': '38.0.1 remote'
        }).
        build();
      break;
    case 'Google Chrome Grid local':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'browserName': 'chrome',
          'version': '42.0.2311.152 m (64-bit)'
        }).
        build();
      break;
    case 'Google Chrome Grid remote':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'browserName': 'chrome',
          'version': '42.0.2311.152 m remote'
        }).
        build();
      break;
    case 'Internet Explorer Grid local':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'browserName': 'internet explorer',
          'version': '11.0 X64'
        }).
        build();
      break;
    case 'Internet Explorer Grid remote':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'browserName': 'internet explorer',
          'version': '11.0 Win32'
        }).
        build();
      break;
    case 'Android Chrome Grid local':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'chromeOptions': {
             'androidPackage': 'com.android.chrome',
             },
          'browserName': 'chrome',
          'platform': 'WINDOWS',
          'version': 'android local'
        }).
        build();
      break;
    case 'Android Chrome Grid remote':
      Web_Driver = new webdriver.Builder().
        usingServer(gridURL).
        withCapabilities({
          'chromeOptions': {
             'androidPackage': 'com.android.chrome',
             },
          'browserName': 'chrome',
          'platform': 'WINDOWS',
          'version': 'android remote'
        }).
        build();
      break;
  }
  if (Web_Browser.indexOf('Android') == -1) {
      Web_Driver.manage().window().maximize();
  }
  return Web_Driver;
}
