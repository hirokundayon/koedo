# -*- coding: utf-8 -*-
from Pages.PageObject               import PageObject
import time

class ITProPage(PageObject):
    firstHandle  = ""
    secondHandle = ""
    def __init__(self, driver):
        PageObject.__init__(self, driver)

    def click_picture(self):
        self.firstHandle = self.driver.window_handles[0]
        picture =\
            self.waiting_element_by_xpath("//img[@alt=\"小江戸らぐ\"]")
        #self.driver.save_screenshot("C:\\home\\hirofumi\\koedo\\a.jpg")
        self.click(picture)
        for handle in self.driver.window_handles:
            if handle != self.firstHandle:
                self.secondHandle = handle
        self.driver.switch_to_window(self.secondHandle)
        picture =\
            self.waiting_element_by_xpath("//img[@src=\"koedlug.jpg\"]")
        time.sleep(5)
        return self

    def quit(self):
        self.driver.switch_to_window(self.secondHandle)
        self.driver.close()

        self.driver.switch_to_window(self.firstHandle)
        self.driver.quit()

    def click_PC_button(self):
        PC_button =\
            self.waiting_element_by_xpath("//img[@src=\"/images/n/itpro/2010/leaf/btn_pc.gif\"]")
        self.click(PC_button)
        return self

