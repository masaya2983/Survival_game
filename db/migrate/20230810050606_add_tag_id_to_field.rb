class AddTagIdToField < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :tag_id, :integer
  end
end
