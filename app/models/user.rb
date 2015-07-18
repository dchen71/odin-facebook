class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  #after_create :send_welcome
  
  #Sends welcome email after creating user
  def send_welcome
    UserMailer.welcome_email(self).deliver_now
  end

  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :friends, class_name: "Relationship",
  					 foreign_key: "friend_id",
  					 dependent: :destroy
  has_many :invites, class_name: "Invite",
  					 foreign_key: "invite_id",
  					 dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


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

  #Facebook authroization
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def feed
    friend_ids = "SELECT friend_id FROM relationships
                  WHERE user_id = :user_id"
    Post.where("user_id IN (#{friend_ids}) 
                OR user_id = :user_id", user_id: id)
  end

end
