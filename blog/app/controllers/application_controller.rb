class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join('app/javascript')

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_default_seo

private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    {locale: I18n.locale}.merge(options)
  end

  def set_default_seo
    @default_title = Seo::DEFAULT_TITLE
    @default_description = Seo::DEFAULT_DESCRIPTION
    @default_robots = Seo::DEFAULT_ROBOTS
  end
end
