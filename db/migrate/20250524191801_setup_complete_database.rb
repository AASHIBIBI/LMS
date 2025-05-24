class SetupCompleteDatabase < ActiveRecord::Migration[5.2]
  def change
    # Create libraries first (no foreign keys)
    create_table :libraries do |t|
      t.string :name
      t.string :university
      t.string :location
      t.integer :max_days
      t.decimal :overdue_fines
      t.timestamps
    end

    # Create students table with Devise fields
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :education_level
      t.string :university
      t.integer :max_book_allowed
      
      # Devise fields
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :provider
      t.string :uid
      t.string :google_token
      t.string :google_refresh_token
      
      t.timestamps
    end
    add_index :students, :email, unique: true
    add_index :students, :reset_password_token, unique: true

    # Create librarians table with Devise fields
    create_table :librarians do |t|
      t.string :email
      t.string :name
      t.string :library
      t.string :university
      
      # Devise fields
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      
      t.timestamps
    end
    add_index :librarians, :email, unique: true
    add_index :librarians, :reset_password_token, unique: true

    # Create admins table with Devise fields
    create_table :admins do |t|
      t.string :email
      t.string :name
      
      # Devise fields
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      
      t.timestamps
    end
    add_index :admins, :email, unique: true
    add_index :admins, :reset_password_token, unique: true

    # Create books table with library foreign key
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.text :language
      t.text :published
      t.text :edition
      t.text :image
      t.text :subject
      t.text :summary
      t.boolean :special
      t.integer :count
      t.references :library, foreign_key: true
      
      t.timestamps
    end

    # Create transactions table with student and book foreign keys
    create_table :transactions do |t|
      t.datetime :start
      t.datetime :end
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      
      t.timestamps
    end

    # Create checkouts table
    create_table :checkouts do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      t.date :issue_date
      t.date :return_date
      t.integer :validity
      
      t.timestamps
    end

    # Create hold_requests table
    create_table :hold_requests do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      
      t.timestamps
    end

    # Create bookmarks table
    create_table :bookmarks do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      
      t.timestamps
    end

    # Create special_books table
    create_table :special_books do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      
      t.timestamps
    end
  end
end
