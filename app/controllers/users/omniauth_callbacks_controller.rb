class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
#    @user = User.from_omniauth_fb(request.env["omniauth.auth"])

#    if @user.persisted?
#      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
##      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
#    else
#      session["devise.facebook_data"] = request.env["omniauth.auth"]
#      redirect_to new_user_registration_url
#    end
#  end


#  def vkontakte
#    @user = User.from_omniauth_vk(request.env["omniauth.auth"])
#    if @user.persisted?
#      sign_in_and_redirect @user, :event => :authentication
#      set_flash_message(:notice, :success, :kind => "Vkontakte") if is_navigational_format?
#    else
#      session["devise.vkontakte_data"] = request.env["omniauth.auth"]
#      redirect_to new_user_registration_url
#      end
#  end

  def failure
    redirect_to root_path
  end



def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:vkontakte, :facebook].each do |provider|
    provides_callback_for provider
  end

end
