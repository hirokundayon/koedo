#!/usr/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)
. ${SCRIPT_DIR}/PageObject.bash

BROWSER=$1
#BROWSER="firefox"
#BROWSER="chrome"
#BROWSER="ie"
#BROWSER="Android"

#ウィンドウオープン
SESSION_ID=$(newSession "${BROWSER}")

#ウィンドウ最大化
maximizeWindow ${SESSION_ID}

#Googleを開く
URL='http://www.google.co.jp/'

goURL ${SESSION_ID} ${URL}

waitByTitle ${SESSION_ID} "Google"

#"小江戸らぐ"と打って検索

SELECTOR='name'
LOCATOR='q'

ELEMENT_ID=$(findElementByName ${SESSION_ID} q)

if [ "${BROWSER}" = edge ]
then
#  echo ${BROWSER} 1>&2
  curl --request "POST" \
       --data '{"script":"elements = document.getElementsByName(\"q\"); elements[0].value=\"小江戸らぐ\";", "args":[]}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/execute/sync"
  curl --request "POST" \
       --data '{"script":"elements = document.getElementsByName(\"f\"); elements[0].submit();", "args":[]}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/execute/sync"
else
#  echo ${BROWSER} 1>&2
  sendKeysToElement ${SESSION_ID} ${ELEMENT_ID} '小江戸らぐ\n'
fi

#日経Linuxの記事へ
TITLE_VALUE='小江戸らぐ - Google 検索'
waitByTitle "${SESSION_ID}" "${TITLE_VALUE}"

if [ "${BROWSER}" = edge ]
then
  sleep 5s
fi
LOCATOR="OSS支える"
ELEMENT_ID=$(findElementByPartialLinkText ${SESSION_ID} "${LOCATOR}")

#LOCATOR='a[href=http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/]'
#ELEMENT_ID=$(findElementByCSSselector ${SESSION_ID} "${LOCATOR}")

clickElement ${SESSION_ID} ${ELEMENT_ID}

#Androidの場合はPC版のページを表示させる
if [ "${BROWSER}" = "Android" ]
then
  LOCATOR="img[src='/images/n/itpro/2010/leaf/btn_pc.gif']"
  ELEMENT_ID=$(findElementByCSSselector ${SESSION_ID} "${LOCATOR}")

  clickElement ${SESSION_ID} ${ELEMENT_ID}
fi

#日経Linuxの記事を表示させる
TITLE_VALUE1="ITpro - エンタープライズICTの総合情報"
TITLE_VALUE2="OSS支える！コミュニティー訪問 - 小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会：ITpro"
TITLE=$(waitByTitle2 ${SESSION_ID} "${TITLE_VALUE1}" "${TITLE_VALUE2}")

if [ "${TITLE}" = "${TITLE_VALUE1}" ] 
then
  #広告のページが表示された時はスキップする
  if [ "${BROWSER}" = edge ]
  then
    sleep 5s
  fi
  LOCATOR="このページをスキップする"
  ELEMENT_ID=$(findElementByLinkText ${SESSION_ID} "${LOCATOR}")

  clickElement ${SESSION_ID} ${ELEMENT_ID}

  waitByTitle ${SESSION_ID} "${TITLE_VALUE2}"
fi

#写真をクリック
if [ "${BROWSER}" = edge ]
then
  sleep 5s
  RESPONSE=$(curl --request "POST" --data '{"using":"css selector", "value":"a[href=\"http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/\?SS\=imgview\&FD=1491996558\&ST\=oss\"]"}' "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")
  ELEMENT_ID=$(echo ${RESPONSE} | sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')
else
  LOCATOR="img[alt=小江戸らぐ]"
  ELEMENT_ID=$(findElementByCSSselector ${SESSION_ID} "${LOCATOR}")
fi

clickElement ${SESSION_ID} ${ELEMENT_ID}

#10秒表示
sleep 10s;

#ウインドウを閉じる
deleteSession ${SESSION_ID}

