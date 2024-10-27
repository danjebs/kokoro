class DashboardController < ApplicationController
  layout "dashboard"

  before_action :set_sidebar_links
  before_action :set_breadcrumbs

  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  private

  def set_sidebar_links
    if current_user.present?
      @sidebar_links = current_user.boards.map do |board|
        { label: board.name, url: board_path(board) }
      end
    end
  end

  def set_breadcrumbs
    add_breadcrumb "Home", root_path
  end
end
