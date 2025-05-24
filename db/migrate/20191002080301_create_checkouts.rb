class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|
      t.bigint :student_id, null: true
      t.bigint :book_id, null: true
      # Removing foreign keys for now
      # t.references :student, null: false, foreign_key: true
      # t.references :book, null: false, foreign_key: true
      t.date :issue_date
      t.date :return_date
      t.integer :validity

      t.timestamps
    end
  end
end
