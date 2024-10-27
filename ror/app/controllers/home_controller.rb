class HomeController < DashboardController
  before_action :set_breadcrumbs, only: %i[index]

  def index
    if current_user.present?
      redirect_to boards_path
    else
      redirect_to new_user_session_path
    end
  end

  private

  def set_breadcrumbs
  end
end
