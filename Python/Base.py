# -*- coding: utf-8 -*-
from selenium import webdriver
import time

class Base:
    def __init__(self, Web_Browser):
        server        = 'localhost'
        server_remote = 'path.to.remote.server'
        gridURL   = 'http://' + server        + ':4444/wd/hub'
        remoteURL = 'http://' + server_remote + ':9515/wd/hub';

        pathToChromedriver         = '/path/To/chromedriver/chromedriver'
        pathToIEDriverServer_x64   = '/path/To/IEDriverServer_x64/IEDriverServer.exe'
        pathToIEDriverServer_Win32 = '/path/To/IEDriverServer_Win32/IEDriverServer.exe'

        self.driver = ''
        if   Web_Browser == "Mozilla Firefox":
            self.driver = webdriver.Firefox()
            self.driver.maximize_window()

        elif Web_Browser == "Google Chrome":
            self.driver =\
                webdriver.Chrome(
                pathToChromedriver
                )
            self.driver.maximize_window()

        elif Web_Browser == "Internet Explorer 32":
            self.driver =\
                webdriver.Ie(
                pathToIEDriverServer_Win32
                )
            self.driver.maximize_window()

        elif Web_Browser == "Internet Explorer 64":
            self.driver =\
                webdriver.Ie(
                pathToIEDriverServer_x64
                )
            self.driver.maximize_window()

        elif Web_Browser == "Android Chrome":
            capabilities = {
                'chromeOptions': {
                    'androidPackage': 'com.android.chrome',
                    }
                }
            self.driver = webdriver.Remote('http://' + server + ':9515/wd/hub',
                                           capabilities)

        elif Web_Browser == "Android Chrome Remote":
            capabilities = {
                'chromeOptions': {
                    'androidPackage': 'com.android.chrome',
                    }
                }
            self.driver = webdriver.Remote(remoteURL,
                                           capabilities)

        elif Web_Browser == "Mozilla Firefox Grid local":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    "browserName": "firefox",
                    "version": "38.0.1",
                    })
            self.driver.maximize_window()

        elif Web_Browser == "Mozilla Firefox Grid remote":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    "browserName": "firefox",
                    "version": "38.0.1 remote",
                    })
            self.driver.maximize_window()

        elif Web_Browser == "Google Chrome Grid local":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    "browserName": "chrome",
                    "version": "42.0.2311.152 m (64-bit)",
                    })
            self.driver.maximize_window()

        elif Web_Browser == "Google Chrome Grid remote":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    "browserName": "chrome",
                    "version": "42.0.2311.152 m remote",
                    })
            self.driver.maximize_window()

        elif Web_Browser == "Internet Explorer Grid local":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    "browserName": "internet explorer",
                    "version": "11.0 X64",
                    })
            self.driver.maximize_window()

        elif Web_Browser == "Internet Explorer Grid remote":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    "browserName": "internet explorer",
                    "version": "11.0 Win32",
                    })
            self.driver.maximize_window()

        elif Web_Browser == "Android Chrome Grid local":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    'chromeOptions': {
                        'androidPackage': 'com.android.chrome',
                        },
                    "browserName": "chrome",
                    "platform": "WINDOWS",
                    "version": "android local"
                    })

        elif Web_Browser == "Android Chrome Grid remote":
            self.driver = webdriver.Remote(
                command_executor=gridURL,
                desired_capabilities={
                    'chromeOptions': {
                        'androidPackage': 'com.android.chrome',
                        },
                    "browserName": "chrome",
                    "platform": "WINDOWS",
                    "version": "android remote"
                    })

    def quit(self):
        # 暫く待った後、終了
        time.sleep(5)

        self.driver.close()

        self.driver.quit()

