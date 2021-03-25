## 概要
Rails学習用アプリ初級編。
バグ/エラーが10個仕込まれているので、探し当てて修正を行う。
内容は基本的なものがほとんど。

- エラー -> 画面が表示されない
- バグ -> 意図した通りの挙動になっていない

中級編は[こちら](https://github.com/Matsushin/qiitan-debug)

## 対象者
- Railsの書籍を1冊以上読んでいるまたはRailsチュートリアルを完了させている程度
- Railsの実務経験がない

## デバッグ実施手順
- 環境構築手順に従って環境構築を行う
- 回答雛形シートをコピー
  - [【Rails学習初級編】デバッグ回答雛形](https://docs.google.com/spreadsheets/d/1wVLgIyGdn2iWxYrlwEMCf-mwLvRpuVeixLeiJm91MKs/edit?usp=sharing)
- ブランチを `debug-test` に変更
- デバッグ開始
- バグ/エラーを見つけたらシートに記入していく
- バグ/エラーの修正ができたらシートに記入していく
  - 1つのバグ/エラーの対応毎にコミットを行う
- 制限時間になったら答えを確認して点数をつける
  - 採点者がいる場合はPRを作成し、チェックしてもらう
  
  
## ルール
- 制限時間は90分とする。
- バグ/エラーを見つければ1点、修正ができれば2点、回答通りの修正ができればさらに1点
  - バグ/エラーは10個あるので最高40点とする。
- 回答はこちらの[シート](https://docs.google.com/spreadsheets/d/1O7Ijf0gCqvE8_vcU2ubn3qHg2Pe9d2WLQgthqWbFOcA/edit?usp=sharing)、[PR](https://github.com/Matsushin/qiitan-debug-beginner/pull/1)を確認する
- 試験中に[動作確認環境](http://qiitan-debug-beginner.herokuapp.com/)は正しい動きの動作確認として操作してもOK。試験中にコードを見るのは禁止。試験前に動作確認やコードを見るのはOKとする。
  - **ユーザ登録時に送信されるメールは迷惑メールまたはGmailだと「プロモーション」に入っている可能性があることに注意**

Basic認証
```
ID: admin
PASS: KdsqAdJJZRfuMxhwFwYuuU4g
```

## 環境構築手順
### 環境
- ruby v2.5.1
- rails v5.2.2
- MySQL 5.7.22

### セットアップ
- Matsushin/QiitanDebugBeginnerリポジトリをあなたのリポジトリに[fork](https://qiita.com/YumaInaura/items/acff806290c8953d3185)してください
  - 自分で答え合わせもする場合はcloneでも可

```
git clone git@github.com:あなたのユーザ名/qiitan-debug-beginner.git
cd qiitan-debug-beginner
```

- 注) GitHubにSSH鍵が登録されておらずクローンに失敗する場合は[こちら](https://qiita.com/knife0125/items/50b80ad45d21ddec61a9)を参考に登録してください

### インストール
- [Docker for Mac](https://www.docker.com/docker-mac) or [Docker for Windows](https://docs.docker.com/docker-for-windows/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### ビルド

```
$ docker-compose build
```

### 各種gemインストール

```
$ docker-compose run web bundle install
```

- 注) ローカル環境にRuby 2.5.1が入っておらずinstallできない場合は[こちら](https://qiita.com/akisanpony/items/ae9d8eed72945de98285)を参考にバージョンアップしてください

### データ準備

```
$ docker-compose run web bundle exec rails db:create # DB作成
$ docker-compose run web bundle exec rails db:migrate # テーブル作成
$ docker-compose run web bundle exec rails db:seed # 初期データ投入
```

データが投入されたか確認

```
docker-compose run web bundle exec rails c # コンソール開始
irb(main):001:0> User.count
   (0.6ms)  SELECT COUNT(*) FROM "users"
=> 2
```

### 起動・終了

### 起動コマンド

以下のコマンドで起動します。

```
$ docker-compose up
```

`http://localhost:3000` にアクセスしてログイン画面が表示されればOK。

### 終了
Ctrl+C
たまにゴミが残るので、  rm tmp/pid/server.pid を削除する必要があるかも


### テスト開始準備
**必ずブランチを切り替えてからテスト実施してください。**
```
git checkout debug-test
```

## メールの確認について
ローカル環境での処理としてはメールは実際には送信されません。
gemの `letter_opener_web` を利用しているため送信したメールは `http://localhost:3000/letter_opener` にアクセスしてブラウザから確認することができます。

## ログインできるユーザについて
`db:seed` を実行すると以下2アカウントかローカルの初期データとして利用できます。[動作確認環境](http://qiitan-debug-beginner.herokuapp.com/)でも利用できます。

1
```
ユーザ名：yamada
メールアドレス：yamada@gmail.com
パスワード：password
```

2
```
ユーザ名：tanaka
メールアドレス：tanaka@gmail.com
パスワード：password
```