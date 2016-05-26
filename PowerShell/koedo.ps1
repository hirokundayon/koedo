<# WebDriver��dll���w�� #>
Add-Type -Path "C:\Selenium\lib\selenium-dotnet\net40\WebDriver.dll";

<# �����ŋN������Web�u���E�U���w�� #>
$browser = $Args -join " ";

<# chromedriver�̃p�X #>
$chromedriver_path = "C:\Selenium\bin\chromedriver_win32";

<# The Internet Explorer Driver Server(32bit�p)�̃p�X #>
$iedriver32_path   = "C:\Selenium\bin\IEDriverServer_Win32";

<# The Internet Explorer Driver Server(64bit�p)�̃p�X #>
$iedriver64_path   = "C:\Selenium\bin\IEDriverServer_x64"

$MicrosoftWebDriver = "C:\Program Files (x86)\Microsoft Web Driver";

<# Selenium Grid Hub��URL #>
$selenium_grid_hub = New-Object System.Uri("http://localhost:4444/wd/hub")

<# �u���E�U�̐ݒ� #>
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
    <# Internet Explorer Win32�� #>
    "ie 32" {
            $driver = New-Object OpenQA.Selenium.IE.InternetExplorerDriver($iedriver32_path);
            $driver.Manage().Window.Maximize();
        }
    <# Internet Explorer x64�� #>
    "ie 64" {
            $driver = New-Object OpenQA.Selenium.IE.InternetExplorerDriver($iedriver64_path);
            $driver.Manage().Window.Maximize();
        }
    <# Edge #>
    "Edge" {
            $driver = New-Object OpenQA.Selenium.Edge.EdgeDriver($MicrosoftWebDriver);
            $driver.Manage().Window.Maximize();
        }
    <# Android��Goofle Chrome #>
    "Android" {
            $options = New-Object OpenQA.Selenium.Chrome.ChromeOptions;
            $options.AddAdditionalCapability("androidPackage","com.android.chrome");

            $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromedriver_path, $options);
        }
    <# Mozilla Firefox(Selenium Grid�o�R) #>
    "Mozilla Firefox Grid" {
            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName", "firefox");
            $capability.SetCapability("platform",    "WINDOWS");
            $capability.SetCapability("version",     "43.0");
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
            $driver.Manage().Window.Maximize();
        }
    <# Goofle Chrome(Selenium Grid�o�R) #>
    "Google Chrome Grid" {
            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName", "chrome");
            $capability.SetCapability("platform",    "WINDOWS");
            $capability.SetCapability("version",     "47.0.2526.106 m (64-bit)");
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
            $driver.Manage().Window.Maximize();
        }
    <# Android��Goofle Chrome(Selenium Grid�o�R) #>
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
    <# Internet Explorer x64��(Selenium Grid�o�R) #>
    "Internet Explorer Grid" {
            $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
            $capability.SetCapability("browserName", "internet explorer");
            $capability.SetCapability("platform",    "WINDOWS");
            $capability.SetCapability("version",     "11.0 X64");
            $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
            $driver.Manage().Window.Maximize();
        }
    <# ����ȊO�̏ꍇ�� Mozilla Firefox #>
    default {
            $browser = "Firefox";
            $driver = New-Object OpenQA.Selenium.Firefox.FirefoxDriver;
            $driver.Manage().Window.Maximize();
        }
}

<# Google�̃y�[�W�ֈړ� #>
$driver.Url = "http://www.google.co.jp/";

<# �\���҂� #>
do
{
  Start-Sleep -s 1
  $title = $driver.Title;
} until($title.Contains("Google"))

<# ���]�˂炮������ #>
$������ = $driver.FindElementsByName("q");
if ($browser.Contains("Edge")) {
    $������.SendKeys("koedo linux itpro");
} else {
    $������.SendKeys("���]�˂炮");
}
$������.Submit();

<# �������ʂ��\�������܂ő҂� #>
do
{
  Start-Sleep -s 1
  $title = $driver.Title;
} until($title.Contains("Google ����"))

<# ���oLinux�̋L����\�������� #>
if ($browser.Contains("Edge")) {
    $link = $driver.FindElementByLinkText("���]�˂炮 - ��z�𒆐S�ɂ�邭��������Linux���[�U�[�� - ITpro");
} else {
    $link = $driver.FindElementByPartialLinkText("OSS�x����I");
}
$link.Click();

<# Android�̏ꍇ��PC�ł̃y�[�W��\�� #>
if ($browser.Contains("Android")) {
    $link = $driver.FindElementByCssSelector("img[src='/images/n/itpro/2010/leaf/btn_pc.gif']");
    $link.Click();
}

<# �L�����\�������܂ő҂� #>
do
{
  Start-Sleep -s 1
  $title = $driver.Title;
} until (($title.Contains("OSS�x����I�R�~���j�e�B�[�K�� - ���]�˂炮 - ��z�𒆐S�ɂ�邭��������Linux���[�U�[��FITpro")) -or ($title.Contains("ITpro - �G���^�[�v���C�YICT�̑������")));


<# Firefox�΍�ł�����x�^�C�g���𓾂� #>
Start-Sleep -s 1
$title = $driver.Title;

<# �L�����\�����ꂽ�ꍇ�̓X�L�b�v���� #>
if ($title.Contains("ITpro - �G���^�[�v���C�YICT�̑������")) {
    $driver.FindElementByPartialLinkText("���̃y�[�W���X�L�b�v����").Click();
    do
    {
        Start-Sleep -s 1
        $title = $driver.Title;
    } until ($title.Contains("OSS�x����I�R�~���j�e�B�[�K�� - ���]�˂炮 - ��z�𒆐S�ɂ�邭��������Linux���[�U�[��FITpro"));
}

<# ���]�˂炮�̏W���ʐ^��\�� #>
if ($browser.Contains("Edge")) {
    Start-Sleep -s 5
    $�ʐ^ = $driver.FindElementByCssSelector("a[href='http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/?SS=imgview&FD=1491996558&ST=oss']");
} else {
    $�ʐ^ = $driver.FindElementByCssSelector("img[alt='���]�˂炮']");
}
$�ʐ^.Click();

<# 10�b�҂� #>
Start-Sleep -s 10

<# �I������ #>
$driver.Close();
$driver.Dispose();
