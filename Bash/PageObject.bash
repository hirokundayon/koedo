#!/bin/bash

# newSession
#   新しいセッションを開始します。
#
function newSession() {
  RESPONSE=$(curl --request "POST" \
    --data '{"desiredCapabilities":{"browserName":"firefox"},"requiredCapabilities":{}}' \
    "http://localhost:4444/wd/hub/session")

  SESSION_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"sessionId":"\([^"]*\)".*/\1/g')

  echo ${SESSION_ID}
}


# go
#   指定したURLへ飛びます。
#     $1 セッションID
#     $2 URL
#
function goURL() {
  SESSION_ID=$1
  URL=$2

  RESPONSE=$(curl --request "POST" \
    --data '{"url":"'${URL}'"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/url")
}

# waitByTitle
#   タイトルが指定された値になるまで待ちます。
#     $1 セッションID
#     $2 タイトルの値
#
function waitByTitle() {
  SESSION_ID=$1
  VALUE=$2

  TITLE=""

  while [ "${TITLE}" != "${VALUE}" ]
  do
    RESPONSE=$(curl --request "GET" \
      "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
    TITLE=$(echo ${RESPONSE} | \
		   sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
  done
}

# findElementByName
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByName() {
  SESSION_ID=$1
  SELECTOR='name'
  LOCATOR=$2

  TITLE=""

  RESPONSE=$(curl --request "POST" \
    --data '{"using":"'${SELECTOR}'","value":"'${LOCATOR}'"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

  ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

  echo "${ELEMENT_ID}"
}

# findElementByPartialLinkText
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByPartialLinkText() {
  SESSION_ID=$1
  SELECTOR="partial link text"
  LOCATOR=$2

  TITLE=""

  RESPONSE=$(curl --request "POST" \
    --data '{"using":"partial link text","value":"'${LOCATOR}'"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

  ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

  echo "${ELEMENT_ID}"
}

# findElementByLinkText
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByLinkText() {
  SESSION_ID=$1
  SELECTOR="link text"
  LOCATOR=$2

  TITLE=""

  RESPONSE=$(curl --request "POST" \
    --data '{"using":"link text","value":"'${LOCATOR}'"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

  ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

  echo "${ELEMENT_ID}"
}

# findElementByCSSselector
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByCSSselector() {
  SESSION_ID=$1
  SELECTOR='css selector'
  LOCATOR=$2

  TITLE=""

  RESPONSE=$(curl --request "POST" \
    --data '{"using":"css selector","value":"'${LOCATOR}'"}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")

  ELEMENT_ID=$(echo ${RESPONSE} | \
    sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

  echo "${ELEMENT_ID}"
}

# clickElement
#   指定された要素をクリックします。
#     $1 セッションID
#     $2 クリックする要素のELEMENT_ID
#
function clickElement() {
  SESSION_ID=$1
  ELEMENT_ID=$2

  TITLE=""

  RESPONSE=$(curl --request "POST" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/click")
}

# sendKeysToElement
#   指定された要素へ打鍵データを送ります。
#     $1 セッションID
#     $2 要素のELEMENT_ID
#     $3 打鍵データ
#
function sendKeysToElement() {
  SESSION_ID=$1
  ELEMENT_ID=$2
  KEYDATA=$3

  RESPONSE=$(curl --request "POST" \
    --data '{"value":["'${KEYDATA}'"]}' \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/value")
}

# deleteSession
#   指定されたセッションを終了させます。
#     $1 セッションID
#
function deleteSession() {
  SESSION_ID=$1

  RESPONSE=$(curl --request "DELETE" \
    "http://localhost:4444/wd/hub/session/"${SESSION_ID})
}
