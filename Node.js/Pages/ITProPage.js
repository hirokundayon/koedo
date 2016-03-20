var webdriver = require('selenium-webdriver'),
    By = require('selenium-webdriver').By;

function ITProPage(driver) {
  this.driver = driver;
}


ITProPage.prototype.click_picture = function (WebBrowser) {
  // Androidの場合の処理
  if (WebBrowser.indexOf('Android') == 0) {
    //var PC_button = '//img[@src="/images/n/itpro/2010/leaf/btn_pc.gif"]';
    var PC_button = 'img[src="/images/n/itpro/2010/leaf/btn_pc.gif"]';
    this.driver.wait(function() {
      //return this.driver.isElementPresent(By.xpath(PC_button));
      return this.driver.isElementPresent(By.css(PC_button));
    }, 10000);
    //this.driver.findElement(By.xpath(PC_button)).click();
    this.driver.findElement(By.css(PC_button)).click();
  }

  // 写真がクリック可能になるまで待つ
  // 小江戸らぐ写真 = '//img[@alt="小江戸らぐ"]';
  var 小江戸らぐ写真 = 'img[alt="小江戸らぐ"]';
  this.driver.wait(function() {
    // return this.driver.isElementPresent(By.xpath(小江戸らぐ写真));
    return this.driver.isElementPresent(By.css(小江戸らぐ写真));
  }, 40000);

  // 写真をクリック
  // this.driver.findElement(By.xpath(小江戸らぐ写真)).click();
  this.driver.findElement(By.css(小江戸らぐ写真)).click();

  return this;
}

ITProPage.prototype.quit = function () {
  driver = this.driver;
  var IntervalValue = 0;
  var Interval = setInterval(function() {
    IntervalValue++;
    //終了条件
    if (IntervalValue == 120) {
	clearInterval(Interval);
	driver.quit();
    }
  }, 500);
}

module.exports = ITProPage;

