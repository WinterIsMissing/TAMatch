class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :username
      t.string :email
      t.string :login_token
      t.string :token_generated_at
      t.string :auth_level
      t.string :uid
      t.string :provider
      t.string :image_url
      t.string :url

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end