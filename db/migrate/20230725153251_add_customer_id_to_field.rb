class AddCustomerIdToField < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :customer_id, :integer
  end
end
