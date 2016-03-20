# -*- coding: utf-8 -*-
from Pages.GoogleResultPage         import GoogleResultPage
from Pages.PageObject               import PageObject

class GoogleHomePage(PageObject):
    def __init__(self, driver):
        PageObject.__init__(self, driver)
        self.get("http://www.google.com")
        self.key_text = self.find_element_by_name("q")

    def input_key(self, value):
        self.input_value(self.key_text, value)
        return self

    def Search(self):
        self.Submit(self.key_text)
        return GoogleResultPage(self.driver)
