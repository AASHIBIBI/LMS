class AddCountToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :count, :integer
  end
end
