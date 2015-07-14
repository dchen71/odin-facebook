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
  has_many :comments, dependent: :destroy

  def invite(other_user)
    other_user.invites.create(user_id: self.id)
  end

  def reject(other_user)
    invites.find_by(user_id: other_user.id).destroy
  end

  def friend(other_user)
    friends.create(user_id: other_user.id)
    other_user.friends.create(user_id: self.id)
  end

  def unfriend(other_user)
    friends.find_by(user_id: other_user.id).destroy
    other_user.friends.find_by(user_id: self.id).destroy
  end

  def friends?(other_user)
    friends.where(user_id: other_user.id).any?
  end

  def invited?(other_user)
    other_user.invites.where(user_id: self.id).any?
  end

  def feed
    friend_ids = "SELECT friend_id FROM relationships
                  WHERE user_id = :user_id"
    Post.where("user_id IN (#{friend_ids}) 
                OR user_id = :user_id", user_id: id)
  end

end
