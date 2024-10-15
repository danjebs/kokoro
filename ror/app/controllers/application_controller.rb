class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Pundit: rescue from unauthorized access
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || super
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."

    if current_user.present?
      respond_to do |format|
        format.html { render file: Rails.root.join("public", "403.html"), status: :forbidden, layout: false }
        format.json { render json: { error: "Forbidden" }, status: :forbidden }
      end
    else
      store_user_location!
      redirect_to new_user_session_path
    end
  end
end
