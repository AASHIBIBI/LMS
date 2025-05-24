class UpdateMigrationDependencies < ActiveRecord::Migration[5.2]
  def change
    # Remove all the drop_table calls
    # We'll create tables in the correct order
    
    # Create libraries first
    create_table :libraries do |t|
      t.string :name
      t.string :university
      t.string :location
      t.integer :max_days
      t.decimal :overdue_fines
      t.timestamps
    end

    # Then create books with a reference to libraries
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
      t.bigint :library_id, null: true
      t.timestamps
    end

    # Create students
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :education_level
      t.string :university
      t.integer :max_book_allowed
      t.timestamps
    end

    # Create admins
    create_table :admins do |t|
      t.string :email
      t.string :name
      t.timestamps
    end

    # Create librarians
    create_table :librarians do |t|
      t.string :email
      t.string :name
      t.string :library
      t.string :university
      t.timestamps
    end
  end
end
