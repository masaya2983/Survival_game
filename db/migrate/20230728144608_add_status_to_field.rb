class AddStatusToField < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :status, :integer
  end
end
