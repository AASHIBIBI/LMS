class CreateBooks < ActiveRecord::Migration[5.2]
  def change
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
      # Removing foreign key constraint for now
      # Will add it back in a separate migration after all tables are created
      # t.references :library, foreign_key: true

      t.timestamps
    end
  end
end
