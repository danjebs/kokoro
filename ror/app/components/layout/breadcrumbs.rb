# frozen_string_literal: true

class Layout::Breadcrumbs < BaseComponent
  def initialize(breadcrumbs: [])
    @breadcrumbs = breadcrumbs || []
  end

  def render?
    @breadcrumbs.present?
  end
end
