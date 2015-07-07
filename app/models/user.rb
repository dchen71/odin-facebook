class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :friends, class_name: "Relationship",
  					 foreign_key: "friend_id",
  					 dependent: :destroy
  has_many :invites, class_name: "Invite",
  					 foreign_key: "invite_id",
  					 dependent: :destroy
end
