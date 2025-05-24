class AddDeviseFields < ActiveRecord::Migration[5.2]
  def change
    # Add Devise columns to students
    change_table :students do |t|
      t.string   :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string   :provider
      t.string   :uid
      t.string   :google_token
      t.string   :google_refresh_token
    end
    add_index :students, :email, unique: true
    add_index :students, :reset_password_token, unique: true

    # Add Devise columns to librarians
    change_table :librarians do |t|
      t.string   :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end
    add_index :librarians, :email, unique: true
    add_index :librarians, :reset_password_token, unique: true

    # Add Devise columns to admins
    change_table :admins do |t|
      t.string   :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end
    add_index :admins, :email, unique: true
    add_index :admins, :reset_password_token, unique: true
  end
end
