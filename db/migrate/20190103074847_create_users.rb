class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, unique: true
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.string :activation_digest
      t.boolean :activated, default: false, null: false
      t.datetime :activated_at
      t.datetime :reset_sent_at

      t.boolean :super_admin, default: false, null: false

      t.timestamps
    end
  end
end
