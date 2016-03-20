var webdriver = require('selenium-webdriver'),
    By = require('selenium-webdriver').By;

function GoogleHomePage(driver, URL) {
  this.driver = driver;
  this.driver.get(URL);
}

GoogleHomePage.prototype.input_key = function(value) {
  this.driver.findElement(By.name('q')).sendKeys(value);
  return this;
}

GoogleHomePage.prototype.submit = function() {
  this.driver.findElement(By.name('q')).submit();
  var GoogleResultPage = require('./GoogleResultPage.js');
  return new GoogleResultPage(this.driver);
}

module.exports = GoogleHomePage;
