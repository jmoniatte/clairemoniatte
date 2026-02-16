class RemovePositionFromPagesAndProjects < ActiveRecord::Migration[8.1]
  def change
    remove_column :pages, :position, :integer, default: 0
    remove_column :projects, :position, :integer, default: 0
  end
end
