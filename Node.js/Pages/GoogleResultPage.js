var webdriver = require('selenium-webdriver'),
    By = require('selenium-webdriver').By;

function GoogleResultPage(driver) {
  this.driver = driver;
}

GoogleResultPage.prototype.waitTitle = function (TitleString) {
  driver = this.driver;
  driver.wait(function() {
    return driver.getTitle().then(function(title) {
      return title === TitleString;
    });
  }, 15000);
  return this;
}

var koedolugArticle = 'a[href=\'http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/\']';

GoogleResultPage.prototype.waitLink = function () {
  this.driver.wait(function() {
    return this.driver.isElementPresent(By.css(koedolugArticle));
  }, 15000);
  return this;
}

GoogleResultPage.prototype.linkClick = function () {
  this.driver.findElement(By.css(koedolugArticle)).click();
  var ITProPage = require('./ITProPage.js');
  return new ITProPage(this.driver);
}

module.exports = GoogleResultPage;
