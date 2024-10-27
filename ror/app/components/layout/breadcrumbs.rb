# frozen_string_literal: true

class Layout::Breadcrumbs < ViewComponent::Base
  def initialize(breadcrumbs: [])
    @breadcrumbs = breadcrumbs || []
  end

  def render?
    @breadcrumbs.present?
  end
end
