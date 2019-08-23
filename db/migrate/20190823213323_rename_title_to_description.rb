class RenameTitleToDescription < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :title, :description
  end
end
