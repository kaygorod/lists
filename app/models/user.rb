class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  rolify
  has_many :lists
  has_many :items
  has_many :votes
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :vkontakte]

  def self.from_omniauth_vk(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid+'@vk.com'
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image
    end
  end

  def self.from_omniauth_fb(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image
    end
  end
end
