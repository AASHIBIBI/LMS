class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :start
      t.datetime :end
      t.bigint :student_id, null: true
      t.bigint :book_id, null: true
      # Removing foreign keys for now
      # Will add them back in a separate migration
      # t.references :student, foreign_key: true
      # t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
