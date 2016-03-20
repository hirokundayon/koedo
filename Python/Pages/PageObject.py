# -*- coding: utf-8 -*-
from selenium                       import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by   import By
from selenium.webdriver.support.ui  import WebDriverWait
from selenium.webdriver.support     import expected_conditions as EC
import time

class PageObject:
    def __init__(self, driver):
        self.driver   = driver

    # 待機
    def Waiting(self, element):
        WebDriverWait(driver, 100).until(
            EC.presence_of_element_located(element)
            )
        return self

    def input_value(self, element, value):
        element.send_keys(Keys.CLEAR)
        element.send_keys(value)
        return self

    def click(self, element):
        element.click();
        return self

    def Submit(self, element):
        element.send_keys(Keys.RETURN)
        return self

    # 部品探索
    def find_element_by_name(self, name):
        return self.driver.find_element_by_name(name)

    # 部品探索&待機
    def waiting_element_by_name(self, name):
        return WebDriverWait(self.driver, 100).until(
            EC.presence_of_element_located((By.NAME, name))
            )

    def waiting_element_by_xpath(self, xpath):
        return WebDriverWait(self.driver, 100).until(
            EC.presence_of_element_located((By.XPATH, xpath))
            )

    def waiting_element_by_link_text(self, link):
        return WebDriverWait(self.driver, 100).until(
            EC.presence_of_element_located((By.LINK_TEXT, link))
            )

    # URL get
    def get(self, URL):
        self.driver.get(URL)
        return self

    def getWindowHandle(self):
       return self.driver.current_window_handle

