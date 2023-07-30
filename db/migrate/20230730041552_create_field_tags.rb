class CreateFieldTags < ActiveRecord::Migration[6.1]
  def change
    create_table :field_tags do |t|
      t.references :field, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.index ["field_id"], name: "index_post_tags_on_post_id"
      t.index ["tag_id"], name: "index_post_tags_on_tag_id"
      t.timestamps
    end
  end
end
