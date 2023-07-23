class CreateReadCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :read_counts do |t|
      t.integer :customer_id
      t.integer :field_id

      t.timestamps
    end
  end
end