#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)
. ${SCRIPT_DIR}/PageObject.bash

#ウィンドウオープン
#SESSION_ID=$(newSession "firefox")
#SESSION_ID=$(newSession "chrome")
SESSION_ID=$(newSession "ie")

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

#日経Linuxの記事を表示させる
TITLE_VALUE1="ITpro - エンタープライズICTの総合情報"
TITLE_VALUE2="OSS支える！コミュニティー訪問 - 小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会：ITpro"
TITLE=$(waitByTitle2 ${SESSION_ID} "${TITLE_VALUE1}" "${TITLE_VALUE2}")

if [ "${TITLE}" = "${TITLE_VALUE1}" ] 
then
  #広告のページが表示された時はスキップする
  LOCATOR="このページをスキップする"
  ELEMENT_ID=$(findElementByLinkText ${SESSION_ID} "${LOCATOR}")

  clickElement ${SESSION_ID} ${ELEMENT_ID}

  waitByTitle ${SESSION_ID} "${TITLE_VALUE2}"
fi

#写真をクリック

LOCATOR="img[alt=小江戸らぐ]"
ELEMENT_ID=$(findElementByCSSselector ${SESSION_ID} "${LOCATOR}")

clickElement ${SESSION_ID} ${ELEMENT_ID}

#10秒表示
sleep 10s;

#ウインドウを閉じる
deleteSession ${SESSION_ID}

