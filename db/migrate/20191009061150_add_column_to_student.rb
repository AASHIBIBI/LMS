class AddColumnToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :provider, :string
    add_column :students, :uid, :string
  end
end
