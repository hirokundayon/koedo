#!/bin/bash

#java -jar /home/hirofumi/Selenium/bin/selenium-server-standalone-2.53.0.jar 
#ウィンドウオープン
RESPONSE=$(curl --request "POST" \
    --data '{"desiredCapabilities":{"browserName":"firefox"},"requiredCapabilities":{}}' \
    "http://localhost:4444/wd/hub/session")



SESSION_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"sessionId":"\([^"]*\)".*/\1/g')

#Googleを開く

RESPONSE=$(curl --request "POST" \
    --data '{"url":"http://www.google.co.jp/"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/url")

#"小江戸らぐ"と打って検索
RESPONSE=$(curl --request "POST" \
    --data '{"using":"name","value":"q"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

RESPONSE=$(curl --request "POST" \
    --data '{"value":["小江戸らぐ\n"]}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/value")

#日経Linuxの記事へ
#TITLE="小江戸らぐ - Google 検索"
TITLE=""

while [ "${TITLE}" != "小江戸らぐ - Google 検索" ]
do
  RESPONSE=$(curl --request "GET" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
  TITLE=$(echo ${RESPONSE} | \
    sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
done

RESPONSE=$(curl --request "POST" \
    --data '{"using":"partial link text","value":"OSS支える！"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

RESPONSE=$(curl --request "POST" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/click")

#広告をスキップ
while [ "${TITLE}" != "ITpro - エンタープライズICTの総合情報" ]
do
  RESPONSE=$(curl --request "GET" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
  TITLE=$(echo ${RESPONSE} | \
    sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
done

  RESPONSE=$(curl --request "POST" \
    --data '{"using":"link text","value":"このページをスキップする"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

  ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

  RESPONSE=$(curl --request "POST" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/click")

#写真をクリック
while [ "${TITLE}" != "OSS支える！コミュニティー訪問 - 小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会：ITpro" ]
do
  RESPONSE=$(curl --request "GET" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
  TITLE=$(echo ${RESPONSE} | \
    sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
done

RESPONSE=$(curl --request "POST" \
    --data '{"using":"css selector","value":"img[alt=\"小江戸らぐ\"]"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

RESPONSE=$(curl --request "POST" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/click")

#10秒表示
sleep 10s;

#ウインドウを閉じる

RESPONSE=$(curl --request "DELETE" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID})

