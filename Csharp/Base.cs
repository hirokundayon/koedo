using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium.Support.UI;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.IE;
using OpenQA.Selenium.Remote;

namespace ConsoleApplication2
{
    class Base
    {
        public IWebDriver driver;
        public String browser;
        public bool isMobile;

        public Base(String browser)
        {
            this.browser = browser;
            switch (browser)
            {
                case "Mozilla Firefox":
                    this.driver = new FirefoxDriver();
                    break;
                case "Google Chrome":
                    this.driver = new ChromeDriver(@"/path/of/chromedriver");
                    break;
                case "Internet Explorer 32":
                    this.driver = new InternetExplorerDriver(@"/path/of/IEDriverServer_Win32");
                    break;
                case "Internet Explorer 64":
                    this.driver = new InternetExplorerDriver(@"/path/of/IEDriverServer_x64");
                    break;
                case "Android Chrome":
                    DesiredCapabilities capability = DesiredCapabilities.Chrome();
                    capability.SetCapability("chromeOptions",
                        new Dictionary<string, object> {
                            { "androidPackage", "com.android.chrome" }
                        });
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.chrome.driver:port/wd/hub"), capability);
                    break;

                case "Mozilla Firefox Grid local":
                    capability = DesiredCapabilities.Firefox();
                    capability.SetCapability("browserName", "firefox");
                    capability.SetCapability("platform", "WINDOWS");
                    capability.SetCapability("version", "43.0");
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;
                case "Mozilla Firefox Grid remote":
                    capability = DesiredCapabilities.Firefox();
                    capability.SetCapability("browserName", "firefox");
                    capability.SetCapability("platform", "WINDOWS");
                    capability.SetCapability("version", "43.0 remote");
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;

                case "Google Chrome Grid local":
                    capability = DesiredCapabilities.Chrome();
                    capability.SetCapability("browserName", "chrome");
                    capability.SetCapability("platform",    "WINDOWS");
                    capability.SetCapability("version",     "47.0.2526.106 m (64-bit)");
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;
                case "Google Chrome Grid remote":
                    capability = DesiredCapabilities.Chrome();
                    capability.SetCapability("browserName", "chrome");
                    capability.SetCapability("platform",    "WINDOWS");
                    capability.SetCapability("version",     "47.0.2526.106 m remote");
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;
			    case "Internet Explorer Grid local":
                    capability = DesiredCapabilities.InternetExplorer();
                    capability.SetCapability("browserName", "internet explorer");
                    capability.SetCapability("platform", "WINDOWS");
                    capability.SetCapability("version", "11.0 X64");
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;
                case "Internet Explorer Grid remote":
                    capability = DesiredCapabilities.InternetExplorer();
                    capability.SetCapability("browserName", "internet explorer");
                    capability.SetCapability("platform", "WINDOWS");
                    capability.SetCapability("version", "11.0 Win32");
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;

                case "Android Chrome Grid local":
                    capability = DesiredCapabilities.Chrome();
                    capability.SetCapability("browserName", "chrome");
                    capability.SetCapability("platform", "WINDOWS");
                    capability.SetCapability("version", "android local");
                    capability.SetCapability("chromeOptions",
                        new Dictionary<string, object> {
                            { "androidPackage", "com.android.chrome" }
                        });
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;
                case "Android Chrome Grid remote":
                    capability = DesiredCapabilities.Chrome();
                    capability.SetCapability("browserName", "chrome");
                    capability.SetCapability("platform", "WINDOWS");
                    capability.SetCapability("version", "android remote");
                    capability.SetCapability("chromeOptions",
                        new Dictionary<string, object> {
                            { "androidPackage", "com.android.chrome" }
                        });
                    this.driver = new RemoteWebDriver(new Uri("http://address.of.grid.server:port/wd/hub"), capability);
                    break;
            }

            this.isMobile = browser.Contains("Android");
        }

        public void quit()
        {
            System.Threading.Thread.Sleep(10000);
            this.driver.Quit();
        }
    }
}
