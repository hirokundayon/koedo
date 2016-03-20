# -*- coding: utf-8 -*-
from Pages.ITProPage                import ITProPage
from Pages.PageObject               import PageObject

class GoogleResultPage(PageObject):
    def __init__(self, driver):
        PageObject.__init__(self, driver)
        #linkTextTitle =\
        #    "小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会 - ITpro";
        #self.link =\
        #    self.waiting_element_by_link_text(linkTextTitle)
        xpath =\
                "//a[@href='http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/']"
        self.link =\
            self.waiting_element_by_xpath(xpath)

    def click_on_PC(self):
        self.click(self.link)
        return ITProPage(self.driver)

    def click_on_SMP(self):
        self.click(self.link)
        return ITProPage(self.driver).click_PC_button()
