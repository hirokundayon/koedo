package koedo;

import com.codeborne.selenide.Configuration;
import com.codeborne.selenide.WebDriverRunner;
import org.openqa.selenium.Platform;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import pages.GoogleHomePage;
import pages.ITproPage;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;

import static com.codeborne.selenide.Selenide.open;

/**
 * Created by hirofumi on 2016/01/03.
 */
public class koedo {
    public static void main(String[] args) {
        //小江戸らぐ写真表示("Mozilla Firefox");
        小江戸らぐ写真表示("Google Chrome");
        // 小江戸らぐ写真表示("Internet Explorer 32");
        // 小江戸らぐ写真表示("Internet Explorer 64");
        // 小江戸らぐ写真表示("Android");
        // 小江戸らぐ写真表示("Android Chrome");
        // 小江戸らぐ写真表示("Mozilla Firefox Grid local");
        // 小江戸らぐ写真表示("Google Chrome Grid local");
        // 小江戸らぐ写真表示("Internet Explorer 64 Grid");
        // 小江戸らぐ写真表示("Android Chrome Grid Local");
        // 小江戸らぐ写真表示("Mozilla Firefox Grid remote");
        // 小江戸らぐ写真表示("Google Chrome Grid remote");
        // 小江戸らぐ写真表示("Internet Explorer 32 Grid");
        // 小江戸らぐ写真表示("Android Chrome Remote");
    }

    public static void 小江戸らぐ写真表示(String ブラウザ) {
        setWebDriver(ブラウザ);

        ITproPage page =
                open("http://google.com/ncr", GoogleHomePage.class)
                        .検索("小江戸らぐ")
                        .リンクをクリック()
                        .写真をクリック(ブラウザ);

        try {
            Thread.sleep(2000);
        } catch (Exception e) {

        }

        page.close();
        //quit();
    }

    protected static void setWebDriver(String ブラウザ) {
        DesiredCapabilities capability;
        String gridServer = "grid.server.address";
        String gridURL    = "http://" + gridServer + ":4444/wd/hub";
        String androidURL = "http://" + gridServer + ":9515/wd/hub";
        switch (ブラウザ) {
            case "Mozilla Firefox":
                break;
            case "Google Chrome":
                System.setProperty(
                        "webdriver.chrome.driver",
                        new File("/path/to/chromedriver").getAbsolutePath());
                Configuration.browser = WebDriverRunner.CHROME;
                break;
            case "Internet Explorer 32":
                System.setProperty(
                        "webdriver.ie.driver",
                        "/path/to/IEDriverServer_Win32/IEDriverServer.exe");
                Configuration.browser = WebDriverRunner.INTERNET_EXPLORER;
                break;
            case "Internet Explorer 64":
                System.setProperty("webdriver.ie.driver",
                        "/path/to/IEDriverServer_x64/IEDriverServer.exe");
                Configuration.browser = WebDriverRunner.INTERNET_EXPLORER;
                break;
            case "Android Chrome":
                ChromeOptions chromeOptions = new ChromeOptions();
                chromeOptions.setExperimentalOption("androidPackage", "com.android.chrome");
                capability = new DesiredCapabilities();
                capability.setCapability(ChromeOptions.CAPABILITY, chromeOptions);
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(androidURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Mozilla Firefox Grid Local":
                capability = DesiredCapabilities.firefox();
                capability.setVersion("43.0");
                capability.setPlatform(Platform.WINDOWS);
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                }
                break;
            case "Google Chrome Grid local":
                capability = DesiredCapabilities.chrome();
                capability.setVersion("47.0.2526.106 m (64-bit)");
                capability.setPlatform(Platform.WINDOWS);
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Mozilla Firefox Grid remote":
                capability = DesiredCapabilities.firefox();
                capability.setVersion("38.0.1 remote");
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Google Chrome Grid remote":
                capability = DesiredCapabilities.chrome();
                capability.setVersion("42.0.2311.90 remote");
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Internet Explorer 32 Grid":
                capability = DesiredCapabilities.internetExplorer();
                capability.setVersion("11.0 Win32");
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Internet Explorer 64 Grid":
                capability = DesiredCapabilities.internetExplorer();
                capability.setVersion("11.0 X64");
                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Android Chrome Grid Local":
                System.out.println("Android Chrome Grid Local");
                chromeOptions = new ChromeOptions();
                chromeOptions.setExperimentalOption("androidPackage", "com.android.chrome");
                capability = DesiredCapabilities.chrome();
                capability.setCapability(ChromeOptions.CAPABILITY, chromeOptions);
                capability.setVersion("android local");

                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            case "Android Chrome remote":
                chromeOptions = new ChromeOptions();
                chromeOptions.setExperimentalOption("androidPackage", "com.android.chrome");
                capability = new DesiredCapabilities();
                capability.setCapability(ChromeOptions.CAPABILITY, chromeOptions);
                capability.setVersion("android");

                try {
                    WebDriverRunner.setWebDriver(
                            new RemoteWebDriver(
                                    new URL(gridURL),
                                    capability
                            )
                    );
                } catch (MalformedURLException e) {

                }
                break;
            default:
                break;
        }
    }

    protected static void quit() {
        // 暫く待って終了
        try {
            Thread.sleep(1000);

            WebDriverRunner.closeWebDriver();
        } catch (InterruptedException e) {
            WebDriverRunner.closeWebDriver();
        }
    }

}
