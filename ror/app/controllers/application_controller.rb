class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Pundit: rescue from unauthorized access
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."

    if current_user.present?
      redirect_to(request.referrer || root_path)
    else
      redirect_to(new_user_session_url)
    end
  end
end
