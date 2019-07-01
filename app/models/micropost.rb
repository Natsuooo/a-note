class Micropost < ApplicationRecord
  
  belongs_to :user
  default_scope -> {order(updated_at: :desc)}
  validates :user_id, presence: true
  
  def memo
    Micropost.where(user_id: id, trash: false)
  end
  
end
