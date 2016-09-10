class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth_fb(request.env["omniauth.auth"])
      sign_in_and_redirect @user
  end


  def vkontakte
    @user = User.from_omniauth_vk(request.env["omniauth.auth"])

      sign_in_and_redirect @user

  end

  def failure
    redirect_to root_path
  end
end


