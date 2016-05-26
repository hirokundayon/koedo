<# WebDriverのdllを指定 #>
Add-Type -Path "C:\Selenium\lib\selenium-dotnet\net40\WebDriver.dll";

<# 引数で起動するWebブラウザを指定 #>
$browser = $Args -join " ";

<# chromedriverのパス #>
$chromedriver_path = "C:\Selenium\bin\chromedriver_win32";

<# The Internet Explorer Driver Server(32bit用)のパス #>
$iedriver32_path   = "C:\Selenium\bin\IEDriverServer_Win32";

<# The Internet Explorer Driver Server(64bit用)のパス #>
$iedriver64_path   = "C:\Selenium\bin\IEDriverServer_x64"

$MicrosoftWebDriver = "C:\Program Files (x86)\Microsoft Web Driver";

<# Selenium Grid HubのURL #>
$selenium_grid_hub = New-Object System.Uri("http://localhost:4444/wd/hub")

<# ブラウザの設定 #>
switch ($browser)
{
    <# Mozilla Firefox #>
    "Firefox" {
            $driver = New-Object OpenQA.Selenium.Firefox.FirefoxDriver;
            $driver.Manage().Window.Maximize();
        }
    <# Google Chrome #>
    "chrome" {
            $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromedriver_path);
            $driver.Manage().Window.Maximize();
        }
    <# Internet Explorer Win32版 #>
    "ie 32" {
            $driver = New-Object OpenQA.Selenium.IE.InternetExplorerDriver($iedriver32_path);
            $driver.Manage().Window.Maximize();
        }
    <# Internet Explorer x64版 #>
    "ie 64" {
            $driver = New-Object OpenQA.Selenium.IE.InternetExplorerDriver($iedriver64_path);
            $driver.Manage().Window.Maximize();
        }
    <# Edge #>
    "Edge" {
            $driver = New-Object OpenQA.Selenium.Edge.EdgeDriver($MicrosoftWebDriver);
            $driver.Manage().Window.Maximize();
        }
    <# AndroidのGoofle Chrome #>
    "Android" {
            $options = New-Object OpenQA.Selenium.Chrome.ChromeOptions;
            $options.AddAdditionalCapability("androidPackage","com.android.chrome");

            $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromedriver_path, $options);
        }
    <# Mozilla Firefox(Selenium Grid経由) #>
    "Mozilla Firefox Grid" {
            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName", "firefox");
            $capability.SetCapability("platform",    "WINDOWS");
            $capability.SetCapability("version",     "43.0");
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
            $driver.Manage().Window.Maximize();
        }
    <# Goofle Chrome(Selenium Grid経由) #>
    "Google Chrome Grid" {
            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName", "chrome");
            $capability.SetCapability("platform",    "WINDOWS");
            $capability.SetCapability("version",     "47.0.2526.106 m (64-bit)");
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
            $driver.Manage().Window.Maximize();
        }
    <# AndroidのGoofle Chrome(Selenium Grid経由) #>
    "Android Grid" {
            $options = @{}
            $options.Add("androidPackage", "com.android.chrome")

            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName",   "chrome");
            $capability.SetCapability("platform",      "WINDOWS");
            $capability.SetCapability("version",       "android local");
            $capability.setCapability("chromeOptions", $options);
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
        }
    <# Internet Explorer x64版(Selenium Grid経由) #>
    "Internet Explorer Grid" {
            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName", "internet explorer");
            $capability.SetCapability("platform",    "WINDOWS");
            $capability.SetCapability("version",     "11.0 X64");
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
            $driver.Manage().Window.Maximize();
        }
    <# それ以外の場合は Mozilla Firefox #>
    default {
            $browser = "Firefox";
            $driver = New-Object OpenQA.Selenium.Firefox.FirefoxDriver;
            $driver.Manage().Window.Maximize();
        }
}

<# Googleのページへ移動 #>
$driver.Url = "http://www.google.co.jp/";

<# 表示待ち #>
do
{
  Start-Sleep -s 1
  $title = $driver.Title;
} until($title.Contains("Google"))

<# 小江戸らぐを検索 #>
$検索窓 = $driver.FindElementsByName("q");
if ($browser.Contains("Edge")) {
    $検索窓.SendKeys("koedo linux itpro");
} else {
    $検索窓.SendKeys("小江戸らぐ");
}
$検索窓.Submit();

<# 検索結果が表示されるまで待つ #>
do
{
  Start-Sleep -s 1
  $title = $driver.Title;
} until($title.Contains("Google 検索"))

<# 日経Linuxの記事を表示させる #>
if ($browser.Contains("Edge")) {
    $link = $driver.FindElementByLinkText("小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会 - ITpro");
} else {
    $link = $driver.FindElementByPartialLinkText("OSS支える！");
}
$link.Click();

<# Androidの場合はPC版のページを表示 #>
if ($browser.Contains("Android")) {
    $link = $driver.FindElementByCssSelector("img[src='/images/n/itpro/2010/leaf/btn_pc.gif']");
    $link.Click();
}

<# 記事が表示されるまで待つ #>
do
{
  Start-Sleep -s 1
  $title = $driver.Title;
} until (($title.Contains("OSS支える！コミュニティー訪問 - 小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会：ITpro")) -or ($title.Contains("ITpro - エンタープライズICTの総合情報")));


<# Firefox対策でもう一度タイトルを得る #>
Start-Sleep -s 1
$title = $driver.Title;

<# 広告が表示された場合はスキップする #>
if ($title.Contains("ITpro - エンタープライズICTの総合情報")) {
    $driver.FindElementByPartialLinkText("このページをスキップする").Click();
    do
    {
        Start-Sleep -s 1
        $title = $driver.Title;
    } until ($title.Contains("OSS支える！コミュニティー訪問 - 小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会：ITpro"));
}

<# 小江戸らぐの集合写真を表示 #>
if ($browser.Contains("Edge")) {
    Start-Sleep -s 5
    $写真 = $driver.FindElementByCssSelector("a[href='http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/?SS=imgview&FD=1491996558&ST=oss']");
} else {
    $写真 = $driver.FindElementByCssSelector("img[alt='小江戸らぐ']");
}
$写真.Click();

<# 10秒待つ #>
Start-Sleep -s 10

<# 終了処理 #>
$driver.Close();
$driver.Dispose();
