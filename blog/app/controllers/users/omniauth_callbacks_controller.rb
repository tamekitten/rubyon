class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    oauth = User.from_omniauth(request.env["omniauth.auth"], (user_signed_in? ? current_user : nil))
    if oauth.changed?
      if (not(oauth.user.changed?) or oauth.user.save) and oauth.save
        @user = oauth.user
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise_facebook_data"] = request.env["omniauth.auth"]
        flash[:notice] = I18n.t("notice.one_more_step") % request.env["omniauth.auth"].provider
        redirect_to new_user_registration_url
      end
    else
      @user = oauth.user
      sign_in_and_redirect @user, event: :authentication
    end
  end

  def failure
    redirect_to root_path
  end
end
