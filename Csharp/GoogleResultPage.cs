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
    class GoogleResultPage : PageObject
    {
        private IWebElement link;

        public GoogleResultPage(Base driverInformation) : base(driverInformation)
        {
            //this.link = this.waitingElementByLinkText("小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会 - ITpro");
			this.link = this.waitingElementByXpath("//a[@href='http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/']");
        }

        public ITProPage click()
        {
            this.click(this.link);
            ITProPage result = new ITProPage(this.driverInformation);
            return this.isMobile ? result.click_PC_button() : result;
        }

        public ITProPage click_on_PC()
        {
            this.click(this.link);
            ITProPage result = new ITProPage(this.driverInformation);
            return result;
        }

        public ITProPage click_on_SMP()
        {
            this.click(this.link);
            ITProPage result = new ITProPage(this.driverInformation);
            return result.click_PC_button();
        }
    }
}
