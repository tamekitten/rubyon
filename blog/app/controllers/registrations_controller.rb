class RegistrationsController < Devise::RegistrationsController
  after_action :add_oauth, only: [:create]

protected

  def add_oauth
    if data = session["devise_facebook_data"] and session["devise_facebook_data"]["info"]
      oauth = Oauth.find_by(uid: data["uid"], provider: data["provider"])

      if !oauth
        oauth = Oauth.create(uid: data["uid"], provider: data["provider"], user: resource, name: data["info"]["name"], email: data["info"]["email"], image_url: data["info"]["image"])
      else
        oauth.user = resource
      end

      if oauth.changed?
        oauth.save
      end
    end
  end
end
