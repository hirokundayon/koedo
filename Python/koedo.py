#!/usr/bin/python3
# -*- coding: utf-8 -*-
from Pages.GoogleHomePage           import GoogleHomePage
from Pages.GoogleResultPage         import GoogleResultPage
from Pages.ITProPage                import ITProPage
from Base                           import Base

Web_Browser = "Mozilla Firefox"
#Web_Browser = "Google Chrome"
#Web_Browser = "Internet Explorer 32"
#Web_Browser = "Internet Explorer 64"
#Web_Browser = "Android Chrome"
#Web_Browser = "Android Chrome Remote"
#Web_Browser = "Android Chrome Grid local"
#Web_Browser = "Android Chrome Grid remote"
#Web_Browser = "Mozilla Firefox Grid local"
#Web_Browser = "Mozilla Firefox Grid remote"
#Web_Browser = "Google Chrome Grid local"
#Web_Browser = "Google Chrome Grid remote"
#Web_Browser = "Internet Explorer Grid local"
#Web_Browser = "Internet Explorer Grid remote"

koedo = Base(Web_Browser)
# Google で検索
if Web_Browser[0:8] == "Android ":
    GoogleHomePage(koedo.driver)\
        .input_key(u"小江戸らぐ")\
        .Search()\
        .click_on_SMP()\
        .click_picture()
else:
    GoogleHomePage(koedo.driver)\
        .input_key(u"小江戸らぐ")\
        .Search()\
        .click_on_PC()\
        .click_picture()

koedo.quit()
