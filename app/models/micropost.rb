class Micropost < ActiveRecord::Base

  #attr_accessible :content, :user_id

  # noi dung nhap o web chi chan attribute :content
  attr_accessible :content
  # binding.pry
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  # binding.pry
  
  belongs_to :user 

  default_scope order: 'microposts.created_at DESC'
end
