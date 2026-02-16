class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :body
      t.integer :position, default: 0
      t.string :thumbnail
      t.timestamps
    end
  end
end
