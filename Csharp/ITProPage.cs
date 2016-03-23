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
    class ITProPage : PageObject
    {
        public ITProPage(Base driverInformation)
            : base(driverInformation)
        {

        }

        public ITProPage clickPicture()
        {
            IWebElement picture = this.waitingElementByXpath("//img[@alt='小江戸らぐ']");
            this.click(picture);
            return this;
        }
        
        public ITProPage click_PC_button()
        {
            IWebElement PC_button = this.waitingElementByXpath("//img[@src='/images/n/itpro/2010/leaf/btn_pc.gif']");
            this.click(PC_button);
            return this;
        }
    }
}
