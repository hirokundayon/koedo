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
    class GoogleHomePage : PageObject
    {
        private IWebElement key;

        public GoogleHomePage(Base driverInformation) : base(driverInformation)
        {
            this.get("http://www.google.com");
            this.key = this.findElementByName("q");
        }

        public GoogleHomePage inputKey(String key)
        {
            this.inputValue(this.key, key);
            return this;
        }

        public GoogleResultPage Search()
        {
            this.submit(this.key);
            return new GoogleResultPage(this.driverInformation);
        }
    }
}
