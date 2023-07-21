class CreateFieldComments < ActiveRecord::Migration[6.1]
  def change
    create_table :field_comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :field_id
      t.timestamps
    end
  end
end
