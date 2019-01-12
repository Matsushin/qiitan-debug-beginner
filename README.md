## 概要
Rails学習用アプリ。

## 対象者
- Railsの書籍を1冊以上読んでいるまたはRailsチュートリアルを完了させている程度
- Railsの実務経験がない

## デバッグ実施手順

## ルール

## 環境構築手順
### 環境
- ruby v2.5.1
- rails v5.2.2
- sqlite

### セットアップ
- Matsushin/QiitanDebugBeginnerリポジトリをあなたのリポジトリに[fork](https://qiita.com/YumaInaura/items/acff806290c8953d3185)してください
  - 自分で答え合わせもする場合はcloneでも可

```
git clone git@github.com:あなたのユーザ名/qiitan-debug-beginner.git
cd qiitan-debug-beginner
```

- 注) GitHubにSSH鍵が登録されておらずクローンに失敗する場合は[こちら](https://qiita.com/knife0125/items/50b80ad45d21ddec61a9)を参考に登録してください

### 各種gemインストール

```
bundle install --path=vendor/bundle
```

- 注) ローカル環境にRuby 2.5.1が入っておらずinstallできない場合は[こちら](https://qiita.com/akisanpony/items/ae9d8eed72945de98285)を参考にバージョンアップしてください

### データ準備

```
rails db:create # DB作成
rails db:migrate # テーブル作成
```

### 画面確認

サーバ起動
```
rails s
```

`http://localhost:3000` にアクセスしてログイン画面が表示されればOK。


## 備考
