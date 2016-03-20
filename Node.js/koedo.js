var Base = require('./Base.js');

//var WebBrowser = 'Mozilla Firefox';
var WebBrowser = 'Google Chrome';
//var WebBrowser = 'Internet Explorer 32';
//var WebBrowser = 'Internet Explorer 64';
//var WebBrowser = 'Android Chrome';
//var WebBrowser = 'Android Chrome Remote';
//var WebBrowser = 'Mozilla Firefox Grid local';
//var WebBrowser = 'Mozilla Firefox Grid remote';
//var WebBrowser = 'Google Chrome Grid local';
//var WebBrowser = 'Google Chrome Grid remote';
//var WebBrowser = 'Internet Explorer Grid local';
//var WebBrowser = 'Internet Explorer Grid remote';
//var WebBrowser = 'Android Chrome Grid local';
//var WebBrowser = 'Android Chrome Grid remote';

var driver = Base.driver(WebBrowser);

var GoogleHomePage = require('./Pages/GoogleHomePage.js');

// Google で検索
var googleResultPage = new GoogleHomePage(driver, 'http://www.google.com')
                             .input_key('小江戸らぐ')
                             .submit()
                             .waitTitle('小江戸らぐ - Google 検索')
                             .waitLink()
                             .linkClick()
                             .click_picture(WebBrowser)
                             .quit();

// 暫く待った後、終了
