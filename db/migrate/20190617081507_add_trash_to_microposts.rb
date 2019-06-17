class AddTrashToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :trash, :boolean, default: false
  end
end
