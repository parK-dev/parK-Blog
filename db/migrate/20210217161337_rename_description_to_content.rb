class RenameDescriptionToContent < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :description, :content
  end
end
