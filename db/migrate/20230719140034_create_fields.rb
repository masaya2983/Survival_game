class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.text :body
      t.integer :user_id
      t.timestamps
    end
  end
end
