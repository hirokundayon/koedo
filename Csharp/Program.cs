using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication2
{
    class Program
    {
        static void Main(string[] args)
        {
            //var driver = new FirefoxDriver();

            Base driverInformation;
            driverInformation = new Base("Mozilla Firefox");

            // driverInformation = new Base("Google Chrome");

            // driverInformation = new Base("Internet Explorer 32");
            // driverInformation = new Base("Internet Explorer 64");
            
            // driverInformation = new Base("Android Chrome");

            // driverInformation = new Base("Mozilla Firefox Grid local");
            // driverInformation = new Base("Mozilla Firefox Grid remote");

            // driverInformation = new Base("Google Chrome Grid local");
            // driverInformation = new Base("Google Chrome Grid remote");

            // driverInformation = new Base("Internet Explorer Grid local");
            // driverInformation = new Base("Internet Explorer Grid remote");

            // driverInformation = new Base("Android Chrome Grid local");
            // driverInformation = new Base("Android Chrome Grid remote");

            new GoogleHomePage(driverInformation).inputKey("小江戸らぐ").Search().click().clickPicture();

            driverInformation.quit();

        }

    }
}
