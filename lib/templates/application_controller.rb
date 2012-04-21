class ApplicationController < ActionController::Base
  layout :layout

  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

protected

  def layout
    if devise_controller?
      "devise"
    else
      "content"
    end
  end

  # TODO: Better error pages

  def not_found
    error :not_found
  end

  def forbidden
    error :forbidden
  end

  def error status=:internal_server_error
    render :text => status.to_s.titleize, :status => status
  end

  # Before filter for asseting an administrator is logged in

  def admin_only!
    authenticate_user! && begin
      forbidden unless current_user.admin?
    end
  end
end
