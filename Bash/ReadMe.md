# Selenium WebDriverを動かすシェルスクリプトの動かし方
<div style="text-align: right;">
東平洋史
</div>

1. はじめに  
   この資料は Selenium WebDriver を動かすシェルスクリプト koedo.bash の動かし方を記述したものです。このシェルスクリプトは次の手順で、今は亡き高橋信頼さんが日経Linuxで書かれた、小江戸らぐに関する記事を表示させます。
   1. Mozilla Firefoxを起動します。
   2. Googleのページを表示します。
   3. 「小江戸らぐ」をキーに検索します。
   4. 日経Linuxの記事へのリンクをクリックします。
   5. 広告のページが表示されるので広告をスキップさせます。
   6. 表示された小江戸らぐメンバーの集合写真をクリックします。
   7. 10秒待ちます。
   8. 起動したMozilla Firefoxを終了させます。
2. 準備
    1. Selenium Standalone Serverのダウンロード  
    次のURLからSelenium Standalone Serverを取得します。  
    <http://www.seleniumhq.org/download/>
3. Selenium Standalone Serverの起動  
    次のコマンド(1行で記述)を叩いてSelenium Standalone Serverを起動します。
    なお、環境変数DISPLAYは表示先の端末に応じて適宜変えてください。  
    `$ DISPLAY=:0.0 java -jar /home/hirofumi/Selenium/bin/selenium-server-standalone-2.53.0.jar`  
    次のメッセージが出力されたら起動完了です。  
    `INFO - Selenium Server is up and running`
4. シェルスクリプトの起動  
   以上で準備完了です。シェルスクリプトを起動しましょう。  
   `$ ./koedo.bash`  
   または  
   `$ ./koedoUsingPageObject.bash`
5. 参考文献
   1. WebDriver  
      Living Document  
      W3C Editor's Draft 28 April 2016  
      <https://w3c.github.io/webdriver/webdriver-spec.html>
   2. Seleniumの薄っすい話4:俺と非公式バインディング  
      <http://qiita.com/hiroshitoda/items/5fa5292ceb1e3e8a9610>
   3. OSS支える！コミュニティー訪問  
      小江戸らぐ - 川越を中心にゆるく活動するLinuxユーザー会  
      <http://itpro.nikkeibp.co.jp/article/COLUMN/20131003/508665/>

