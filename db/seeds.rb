# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if User.count.zero?
  User.transaction do
    # 管理者
    user1 = User.new(username: 'yamada', email: 'yamada@gmail.com', super_admin: true, password: 'password', activated: true, activated_at: Time.current)
    user1.save!

    # 一般ユーザ
    user2 = User.new(username: 'tanaka', email: 'tanaka@gmail.com', password: 'password', activated: true, activated_at: Time.current)
    user2.save!

    50.times do |count|
      number = count + 1
      user1.articles.create!(title: "記事タイトル#{number}", body: "#{number}番目の記事投稿です。")
    end

    body = <<~EOS
      # はじめに
      1対多で関連するデータを1つのフォーム画面にしたい時、 みなさんはどのようなコードを書きますか？
      
      # nested_form との比較
      ## ダウンロード数
      今まで聞いたことのない名前だったのでまずは知名度がどうなのかダウンロード数を調べました。
  
      ![Search_--_BestGems.png](https://qiita-image-store.s3.amazonaws.com/0/41362/df1b3dbc-80a0-662d-8abe-1cca55c0cd51.png "Search_--_BestGems.png")
      
      ## モデル
      モデルのコードは以下の通りです。
      ProjectとTaskが1対多の関係となっています。
      
      ```ruby
      # project.rb
      class Project < ActiveRecord::Base
        has_many :tasks, dependent: :destroy, inverse_of: :project
        accepts_nested_attributes_for :tasks, allow_destroy: true
      
        validates :name, presence: true
      end
      ```
      
      ```ruby
      # task.rb
      class Task < ActiveRecord::Base
        belongs_to :project
      
        validates :name, presence: true
      end
      ```
      # 結論
      調査結果としては知名度は日本では全然ないようだが主な機能や導入方法まで nested_form とほとんど変わらない。
      
      # 参考サイト
      [1対多の関連を持つオブジェクトを編集可能なフォーム](http://rails.densan-labs.net/form/relation_register_form.html)
    EOS

    article1 = user1.articles.create!(title: 'nested_form はもう古い！？ Cocoon で作る1対多のフォーム', body: body)
    article2 = user2.articles.create!(title: '記事タイトル', body: 'ここに本文が入ります')
    article1.comments.create!(user: user2, body: '参考になりました！')
    article1.comments.create!(user: user1, body: '良かったです！！')
    user1.likes.create!(article: article2)
    user2.likes.create!(article: article1)
    user1.stocks.create!(article: article2)
  end
end
