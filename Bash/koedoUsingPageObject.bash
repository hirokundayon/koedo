#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)
. ${SCRIPT_DIR}/PageObject.bash

# Selenium Server 起動
JAR_FILE="/home/hirofumi/Selenium/bin/selenium-server-standalone-2.53.0.jar"
JAVA_CMD="DISPLAY=:0.0 java -jar "
ALIVE=`ps -ef | grep "${JAR_FILE}" | grep -v grep | wc -l`

#if [ ${ALIVE} = 0 ]; then
#  DISPLAY=:0.0 java -jar ${JAR_FILE}
#fi
#java -jar /home/hirofumi/Selenium/bin/selenium-server-standalone-2.53.0.jar 

#ウィンドウオープン
#SESSION_ID=$(newSession "firefox")
SESSION_ID=$(newSession "chrome")

#ウィンドウ最大化
maximizeWindow ${SESSION_ID}

#Googleを開く
URL='http://www.google.co.jp/'

goURL ${SESSION_ID} ${URL}

#"小江戸らぐ"と打って検索
SELECTOR='name'
LOCATOR='q'

ELEMENT_ID=$(findElementByName ${SESSION_ID} q)

sendKeysToElement ${SESSION_ID} ${ELEMENT_ID} '小江戸らぐ\n'

#日経Linuxの記事へ
TITLE_VALUE="小江戸らぐ - Google 検索"
waitByTitle "${SESSION_ID}" "${TITLE_VALUE}"

LOCATOR="OSS支える！"
ELEMENT_ID=$(findElementByPartialLinkText ${SESSION_ID} "${LOCATOR}")

#LOCATOR='a[href=http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/]'
#ELEMENT_ID=$(findElementByCSSselector ${SESSION_ID} "${LOCATOR}")

clickElement ${SESSION_ID} ${ELEMENT_ID}

#広告をスキップ
TITLE_VALUE="ITpro - エンタープライズICTの総合情報"
waitByTitle ${SESSION_ID} "${TITLE_VALUE}"

LOCATOR="このページをスキップする"
ELEMENT_ID=$(findElementByLinkText ${SESSION_ID} "${LOCATOR}")

clickElement ${SESSION_ID} ${ELEMENT_ID}

#写真をクリック
TITLE_VALUE="OSS支える！コミュニティー訪問 - 小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会：ITpro"
waitByTitle ${SESSION_ID} "${TITLE_VALUE}"

LOCATOR="img[alt=小江戸らぐ]"
ELEMENT_ID=$(findElementByCSSselector ${SESSION_ID} "${LOCATOR}")

clickElement ${SESSION_ID} ${ELEMENT_ID}

#10秒表示
sleep 10s;

#ウインドウを閉じる
deleteSession ${SESSION_ID}

# Selenium Server 停止
#ps -ef | grep ${JAR_FILE} | grep -v grep | cut -f 2 -d' ' | xargs kill

