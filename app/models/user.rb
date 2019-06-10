class User < ApplicationRecord
  
  before_save {email.downcase!}
  
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
  
end
