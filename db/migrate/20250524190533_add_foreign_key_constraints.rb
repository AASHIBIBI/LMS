class AddForeignKeyConstraints < ActiveRecord::Migration[5.2]
  def change
    # Create transactions table with foreign keys
    create_table :transactions do |t|
      t.datetime :start
      t.datetime :end
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    
    # Create checkouts table with foreign keys
    create_table :checkouts do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      t.date :issue_date
      t.date :return_date
      t.integer :validity
      t.timestamps
    end
    
    # Create hold_requests table with foreign keys
    create_table :hold_requests do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    
    # Create bookmarks table with foreign keys
    create_table :bookmarks do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    
    # Create special_books table with foreign keys
    create_table :special_books do |t|
      t.references :student, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    
    # Add foreign key from books to libraries
    add_foreign_key :books, :libraries, column: :library_id
  end
end
