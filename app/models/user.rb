class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :friend_id, presence: true
  validates :invite_id, presence: true

  has_many :posts, dependent: :destroy
  has_many :friends, class_name: "Relationship",
  					 foreign_key: "friend_id",
  					 dependent: :destroy
  has_many :invitations, class_name: "Relationship",
  					 	 foreign_key: "invite_id",
  					 	 dependent: :destroy
end
