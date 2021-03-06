class User < ApplicationRecord
  
  has_many :microposts, dependent: :destroy
  
  attr_accessor :remember_token, :reset_token
  
  before_save {email.downcase!}
  
  default_scope -> {order(updated_at: :desc)}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: {maximum: 255}, 
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  
  has_secure_password
  VALIDE_PASSWORD_REGEX = /\A[a-z\d]+\z/i
  validates :password,  presence: true, 
                        length: {minimum: 6},
                        format: {with: VALIDE_PASSWORD_REGEX}
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token=User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def create_reset_digest
    self.reset_token=User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def memo
    Micropost.where(user_id: id, trash: false)
  end
  
  def form
    Micropost.where(user_id: id, trash: false).first
  end
  
  def send_register_account_email
    RegisterMailer.register_account(self).deliver_now
  end
    
end
