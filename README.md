# ポートフォリオアプリについて

## 使用技術

### フロント: HTML, css(sass), Javascript, jquery

### サーバーサイド: Ruby, Ruby on rails(テストとしてRSpecを使用), heroku, postgresql

## アプリの概要

### アプリについて: このアプリは近くの人との貸し借りを手伝うアプリです。近くにいる人物を検索し、メッセージを送り、貸し借りの交渉を行うことができます。

### アプリの使い方: まず、メールアドレスを用いて新規登録(アカウントがすでにある場合はログイン)します。この際twitterを使ったログインもできます。ログイン後リクエストページを訪れると現在地取得のボタンを押します。すると近くのユーザーの投稿が表示されます。もし気になる投稿があればそれをクリックし、詳細ページに行きます。詳細ページでは、その投稿の詳細とメッセージルームを作るリンクが表示されています。”貸せる”という文字をクリックするとメッセージルームに移動し、投稿の作成者とメッセージのやり取りを行います。なお、作成したメッセージルームはページ右側のメニューから一覧で見ることができます。

### 使用するときの注意: メールを送る操作はできません。コードはしっかり動いているので、単純にお金の問題です、、。もしアプリを使用する場合は、
### """email:keigo@kei.com , password: password"""
### でログインしてください。

## アプリの課題

### 本番環境でメールが送れない: 本番環境でメールを送ることができません。上述の通り、本番環境でメールを送るのにお金がかかるので設定しておりません。

### デザインが簡素すぎる: 時間の問題(春休み中にアプリを完成させたかった。)ため、デザインは最低限です。レスポンシブにも対応していないので、パソコンの画面でアプリを操作させてください。

## 今後の展望

### デザインの強化: デザインをもっとしっかりとし、モダンなデザイン、レスポンシブ対応、アニメーションをつけていきます。

### メール送信機能の導入: メールを送れるようにします。さらに通知機能も導入していきます。

### Docker, CircleCIの導入: Docker,CircleCIとを使って仮想環境の構築、テスト、デプロイ等を自動化していきます。

### AWSのEC2を用いたデプロイ

