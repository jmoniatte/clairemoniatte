class CreatePages < ActiveRecord::Migration[8.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body
      t.integer :position, default: 0
      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
