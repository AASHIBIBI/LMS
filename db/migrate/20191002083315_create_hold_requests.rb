class CreateHoldRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :hold_requests do |t|
      t.bigint :student_id, null: true
      t.bigint :book_id, null: true
      # t.references :student, null: false, foreign_key: true
      # t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
