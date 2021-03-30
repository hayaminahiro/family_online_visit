# README
# Online Visit
これからの暮らしに欠かすことのできない要素としてオンラインをとらえ離れていてもすぐに繋がれる“Online Visit(オンラインビジット)”を作りました。
ログインすることで 面会予約、ビデオチャット、写真の閲覧 が可能になります。
<img width="1680" alt="スクリーンショット 2021-03-29 12 39 43" src="https://user-images.githubusercontent.com/50825013/112784150-de568c80-908b-11eb-9249-03d4a4ce2646.png">

## 概要
感染症拡大による面会制限により、福祉施設に入居されているご利用者様とご家族様との面会・交流が事実上難しくなりました。そのような中オンライン上で面会の予約・ビデオチャットができるシステムを構築しました。また施設内に入居されているご利用者様のご様子をご家族様が知ることも難しくなりましたが、施設職員がご利用者様の普段のご様子を写真で投稿できる機能「思い出アルバム」を作成し、ご家族はどんなに遠く離れていても、ご利用者様の普段のご様子を知ることができるようになります。

***OnlineVisit/heroku_URL***　[https://family-online-visit.herokuapp.com/](https://family-online-visit.herokuapp.com/)

***OnlineVisit/AWS_URL(現在閉鎖中)***　[https://family-online-visit.herokuapp.com/](https://family-online-visit.herokuapp.com/)

## フロントエンド
* HTML/CSS
* Scss
* Bulma
* javascript
* jQuery
* Vue.js

## バックエンド
* Ruby 2.5.3
* Ruby on Rails 5.2.3

## データベース
* MySQL 5.7

## 開発環境
* Docker/docker-compose
* 開発環境：VScode
* CircleCI/CD(Rspec、Rubocop自動化)

## 本番環境①/heroku
* Puma

## 本番環境②/AWS
* EC2、RDS for MySQL、ALB、Route53、VPC、ACM、S3
* Nginx、unicorn

## AWSインフラ構成図
<img width="1140" alt="スクリーンショット 2021-03-30 20 45 11" src="https://user-images.githubusercontent.com/50825013/112983635-e51ef580-9198-11eb-9152-2e961593ef89.png">

## タスク管理
* Git
* GitHub
* issue(GitHub)

## 対応端末
* PC
* iPhone
* iPad
* Android

## 対応ブラウザ
* Chrome
* safari

## 主要機能一覧
### 認証機能
> 新規登録/ログイン/ログアウト機能(devise)
* 施設（管理者）側とご家族側の複数devise
* 郵便番号自動住所検索機能

> ユーザー編集機能
* 個人情報の登録・編集
* プロフィール画像と背景画像の設定

### ご家族側機能
> 施設検索・登録機能
* ここで登録した施設のHOMEページにアクセスできるようになります。

> 利用者登録申請機能
* 施設側に登録している利用者と多対多で紐付ける為の申請機能です。
* ここで申請して施設側で承認されると、ご利用者の情報にアクセスできるようになります。

> マイページ
* 予約の確認カレンダー
* 投稿された思い出アルバム(写真)閲覧機能
* 写真のフォルダ整理機能
* 登録施設確認

> 面会予約機能
* 面会の予約決定、キャンセル機能
* 月間/週間カレンダー切替機能

> ビデオ通話機能(SkyWay)
* 音量調整、画面拡大、ピクチャーインピクチャー機能
* メッセージ送信機能

> お知らせ表示機能
* 管理者、各施設から投稿されたお知らせを表示

> お問い合わせ機能(各施設宛、システム管理者宛)
* システム管理者、各施設へメールでお問い合わせする事ができます。

### 施設側機能
> HOMEページ
* 予約詳細設定機能：予約可能な曜日と時間帯を設定する事ができます。
* 予約の確認、キャンセル
* 登録申請：利用者登録申請の確認・承認・否認・確認メール送信機能
* 管理者からのお知らせ表示

> 利用者一覧ページ
* 利用者CRUD・退所機能
* 利用者CSVインポート機能

> 面会予約機能
* 過去の予約一覧表示（５年後自動削除）
* 新規予約の確認機能
* その他、ご家族側と同じ

> ビデオ通話機能(SkyWay)
* RoomNameの設定機能（設定後ビデオチャット可能になる）
* その他、ご家族側と同じ

> 思い出アルバム機能
* 思い出アルバムCRUD機能
* 最大８枚の写真を一つのアルバムとして投稿可能
* 思い出アルバムの追加機能(行事ごとに思い出アルバムを関連付ける)
* 写真の拡大機能（写真の詳細情報も確認可能）

> お知らせ機能
* 施設全体（またはシステム管理者）のお知らせ投稿機能
* メッセージ・画像・動画を投稿可能

> お問い合わせ機能
* システム管理者へメールでお問い合わせする事ができます。
* ご家族からのお問い合わせ一覧を表示

## 使用API
* SkyWay
* 郵便番号検索API
