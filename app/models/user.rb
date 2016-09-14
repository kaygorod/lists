class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :lists
  has_many :items
  has_many :votes
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :vkontakte]
  ROLES = %i[user admin]

#  def self.from_omniauth_vk(auth)
#    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#      user.email = auth.info.email
#      user.password = Devise.friendly_token[0,20]
#      user.username = auth.info.name   # assuming the user model has a name
#      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image
#    end
#  end

#  def self.from_omniauth_fb(auth)
#    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#      user.email = auth.info.email
#      user.password = Devise.friendly_token[0,20]
#      user.username = auth.info.name   # assuming the user model has a name
#      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image
#    end
#  end




  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Получить identity пользователя, если он уже существует
    identity = Identity.find_for_oauth(auth)

    # Если signed_in_resource предоставлен оно всегда переписывает существующего пользователя
    # что бы identity не была закрыта случайно созданным аккаунтом.
    # Заметьте, что это может оставить зомби-аккаунты (без прикрепленной identity)
    # которые позже могут быть удалены
    user = signed_in_resource ? signed_in_resource : identity.user

    # Создать пользователя, если нужно
    if user.nil?

      # Получить email пользователя, если его предоставляет провайдер
      # Если email не был предоставлен мы даем пользователю временный и просим
      # пользователя установить и подтвердить новый в следующим шаге через UsersController.finish_signup
      #email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email# if email_is_verified
      user = User.where(:email => email).first if email

      # Создать пользователя, если это новая запись
      if user.nil?
        user = User.new(
          #name: auth.extra.raw_info.name,
          username: auth.info.name || auth.uid,
          email: email,
          password: Devise.friendly_token[0,20],
          remote_avatar_url: auth.info.image.gsub('http://','https://')
        )
        #user.skip_confirmation!
        user.save!
      end
    end

    # Связать identity с пользователем, если необходимо
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end
