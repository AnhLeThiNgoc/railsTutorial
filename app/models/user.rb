# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  before_save { |user| user.email = email.downcase }
  # validation
  validates :name, presence: true, length: {maximum: 100}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false} 
  validates :password, presence: true, length: {minimum: 1}
  validates :password_confirmation, presence: true
  # mot thong bao tot hon cho viec quen password
  after_validation {self.errors.messages.delete(:password_digest)}
  has_secure_password

  has_many :microposts, dependent: :destroy # micropost bi destroy cung voi User

  def feed
    Micropost.where("user_id = ?", id)
  end
end
