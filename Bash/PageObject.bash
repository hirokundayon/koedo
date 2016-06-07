#!/usr/bin/bash

# newSession
#   新しいセッションを開始します。
#
function newSession() {
    local BROWSER=$1
    local RESPONSE=""

    case ${BROWSER} in
	firefox )
	    RESPONSE=$(curl --request "POST" \
			    --data '{"desiredCapabilities":{"browserName":"firefox"},"requiredCapabilities":{}}' \
			    "http://localhost:4444/wd/hub/session")
	    ;;
	chrome )
	    RESPONSE=$(curl --request "POST" \
			    --data '{"desiredCapabilities":{"browserName":"chrome"},"requiredCapabilities":{}}' \
			    "http://localhost:4444/wd/hub/session")
	    ;;
	ie )
	    RESPONSE=$(curl --request "POST" \
			    --data '{"desiredCapabilities":{"browserName":"internet explorer"},"requiredCapabilities":{}}' \
			    "http://localhost:4444/wd/hub/session")
	    ;;
	edge )
	    RESPONSE=$(curl --request "POST" \
			    --data '{"desiredCapabilities":{"browserName":"MicrosoftEdge"},"requiredCapabilities":{}}' \
			    "http://localhost:4444/wd/hub/session")
	    ;;
	Android )
	    RESPONSE=$(curl --request "POST" \
			    --data '{"desiredCapabilities":{"chromeOptions": {"androidPackage":"com.android.chrome"},"browserName":"chrome"},"requiredCapabilities":{}}' \
			    "http://localhost:4444/wd/hub/session")
	    ;;
    esac
    
    local SESSION_ID=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"sessionId":"\([^"]*\)".*/\1/g')
    echo ${SESSION_ID}
}

# maximizeWindow
#  Webブラウザのウィンドウを最大化します。
#     $1 セッションID
#
function maximizeWindow() {
    local SESSION_ID=$1
    RESPONSE=$(curl --request "POST" \
		    "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/window/maximize")
}


# go
#   指定したURLへ飛びます。
#     $1 セッションID
#     $2 URL
#
function goURL() {
    local SESSION_ID=$1
    local URL=$2

    local RESPONSE=$(curl --request "POST" \
			  --data '{"url":"'${URL}'"}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/url")
}

# getTitle
#   タイトルを取得します。
#     $1 セッションID
function getTitle() {
    local SESSION_ID=$1
    local RESPONSE=$(curl --request "GET" \
			      "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
    local TITLE=$(echo ${RESPONSE} | \
		       sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
    echo ${TITLE}
}

# waitByTitle
#   タイトルが指定された値になるまで待ちます。
#     $1 セッションID
#     $2 タイトルの値
#
function waitByTitle() {
    local SESSION_ID=$1
    local VALUE=$2

    local TITLE=""

    while [ "${TITLE}" != "${VALUE}" ]
    do
	local RESPONSE=$(curl --request "GET" \
			      "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
	TITLE=$(echo ${RESPONSE} | \
		       sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
    done
}

# waitByTitle2
#   タイトルが指定された値になるまで待ちます。
#     $1 セッションID
#     $2 タイトル候補その1
#     $3 タイトル候補その2
#
function waitByTitle2() {
    local SESSION_ID=$1
    local VALUE1=$2
    local VALUE2=$3

    local TITLE=""

    while [ "${TITLE}" != "${VALUE1}" ] && [ "${TITLE}" != "${VALUE2}" ]
    do
	local RESPONSE=$(curl --request "GET" \
			      "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/title")
	TITLE=$(echo ${RESPONSE} | \
		       sed -e 's/^.*"value":"\([^"]*\)".*$/\1/g')
    done

    echo ${TITLE}
}

# findElementByName
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByName() {
    local SESSION_ID=$1
    local SELECTOR='name'
    local LOCATOR=$2
    local RESPONSE=""
    local STATE=""

    while [ "${STATE}" != "success" ]
    do
        RESPONSE=$(curl --request "POST" \
			  --data '{"using":"'${SELECTOR}'","value":"'${LOCATOR}'"}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")
        STATE=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"state":"\([^"]*\)".*$/\1/g')
    done

    local ELEMENT_ID=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

    echo "${ELEMENT_ID}"
}

# findElementByPartialLinkText
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByPartialLinkText() {
    local SESSION_ID=$1
    local SELECTOR="partial link text"
    local LOCATOR=$2

    local RESPONSE=""
    local STATE=""

    while [ "${STATE}" != "success" ]
    do
        RESPONSE=$(curl --request "POST" \
			  --data '{"using":"partial link text","value":"'${LOCATOR}'"}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")
        STATE=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"state":"\([^"]*\)".*$/\1/g')
    done

    local ELEMENT_ID=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

    echo "${ELEMENT_ID}"
}

# findElementByLinkText
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByLinkText() {
    local SESSION_ID=$1
    local SELECTOR="link text"
    local LOCATOR=$2

    local RESPONSE=""
    local STATE=""

    while [ "${STATE}" != "success" ]
    do
        RESPONSE=$(curl --request "POST" \
			  --data '{"using":"link text","value":"'${LOCATOR}'"}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")
        STATE=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"state":"\([^"]*\)".*$/\1/g')
    done

    local ELEMENT_ID=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

    echo "${ELEMENT_ID}"
}

# findElementByCSSselector
#   指定された要素を取得します。
#     $1 セッションID
#     $2 locator
#
function findElementByCSSselector() {
    local SESSION_ID=$1
    local SELECTOR='css selector'
    local LOCATOR=$2

    local RESPONSE=""
    local STATE=""

    while [ "${STATE}" != "success" ]
    do
        RESPONSE=$(curl --request "POST" \
			  --data '{"using":"css selector","value":"'${LOCATOR}'"}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element")
        STATE=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"state":"\([^"]*\)".*$/\1/g')
    done

    local ELEMENT_ID=$(echo ${RESPONSE} | \
			      sed -e 's/^.*"ELEMENT":"\([^"]*\)".*$/\1/g')

    echo "${ELEMENT_ID}"
}

# clickElement
#   指定された要素をクリックします。
#     $1 セッションID
#     $2 クリックする要素のELEMENT_ID
#
function clickElement() {
    local SESSION_ID=$1
    local ELEMENT_ID=$2

    local RESPONSE=$(curl --request "POST" \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/click")
}

# sendKeysToElement
#   指定された要素へ打鍵データを送ります。
#     $1 セッションID
#     $2 要素のELEMENT_ID
#     $3 打鍵データ
#
function sendKeysToElement() {
    local SESSION_ID=$1
    local ELEMENT_ID=$2
    local KEYDATA=$3

    local RESPONSE=$(curl --request "POST" \
			  --data '{"value":["'${KEYDATA}'"]}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/element/"${ELEMENT_ID}"/value")
}

# executeScript
#   指定されたJavascriptを実行させます。
#     $1 セッションID
#     $2 実行するJavascript
#
function executeScript() {
    local SESSION_ID=$1
    local SCRIPT=$2

    local RESPONSE=$(curl --request "POST" \
			  --data '{"script":"'${SCRIPT}'", "args":[]}' \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID}"/execute/sync")
}

# deleteSession
#   指定されたセッションを終了させます。
#     $1 セッションID
#
function deleteSession() {
    local SESSION_ID=$1

    local RESPONSE=$(curl --request "DELETE" \
			  "http://localhost:4444/wd/hub/session/"${SESSION_ID})
}
