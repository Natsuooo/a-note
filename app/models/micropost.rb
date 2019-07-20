class Micropost < ApplicationRecord
  
  belongs_to :user
  default_scope -> {order(updated_at: :desc)}
  validates :user_id, presence: true
  
  def memo
    Micropost.where(user_id: id, trash: false)
  end
  
  def form
    Micropost.where(user_id: id, trash: false).first
  end
  
  
  def trash
    Micropost.where(user_id: id, trash: true)
  end
  
  def trash_view
    Micropost.where(user_id: id, trash: true).first
  end
  
end
