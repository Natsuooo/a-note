class RenameTitreColumnToMicroposts < ActiveRecord::Migration[5.2]
  def change
    remove_column :microposts, :content, :text
    add_column :microposts, :title, :string
    add_column :microposts, :body, :text
  end
end
