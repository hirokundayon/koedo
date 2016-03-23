using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.PageObjects;
using OpenQA.Selenium.Support.UI;

namespace ConsoleApplication2
{
    class PageObject
    {
        public Base driverInformation;
        public IWebDriver driver;
        public String browser;
        public bool isMobile;

        public PageObject(Base driverInformation)
        {
            this.driverInformation = driverInformation;
            this.driver = driverInformation.driver;
            this.browser = driverInformation.browser;
            this.isMobile = driverInformation.isMobile;
            if (!this.isMobile)
            {
                this.driver.Manage().Window.Maximize();
            }
        }

        // 入力
        public PageObject inputValue(IWebElement element, String value)
        {
            element.Clear();
            element.SendKeys(value);
            return this;
        }

        // クリック
        public PageObject click(IWebElement element)
        {
            element.Click();
            return this;
        }

        // Submit
        public PageObject submit(IWebElement element)
        {
            element.Submit();
            return this;
        }

        // 部品探索
        public IWebElement findElementByName(String name)
        {
            return this.driver.FindElement(By.Name(name));
        }

        // 部品探索&待機
        public IWebElement waitingElementByName(String name)
        {
            var wait = new WebDriverWait(this.driver, TimeSpan.FromSeconds(30));
            wait.Until(drv => this.driver.FindElement(By.Name(name)));
            return this.driver.FindElement(By.Name(name));
        }

        public IWebElement waitingElementByXpath(String xpath)
        {
            var wait = new WebDriverWait(this.driver, TimeSpan.FromSeconds(30));
            wait.Until(drv => this.driver.FindElement(By.XPath(xpath)));
            return this.driver.FindElement(By.XPath(xpath));
        }

        public IWebElement waitingElementByLinkText(String linkText)
        {
            var wait = new WebDriverWait(this.driver, TimeSpan.FromSeconds(30));
            wait.Until(drv => this.driver.FindElement(By.LinkText(linkText)));
            return this.driver.FindElement(By.LinkText(linkText));
        }
        
        // URL get
        public PageObject get(String URL)
        {
            this.driver.Navigate().GoToUrl(URL);
            return this;
        }
    }
}
