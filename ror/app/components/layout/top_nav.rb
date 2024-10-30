# frozen_string_literal: true

class Layout::TopNav < BaseComponent
  def initialize(breadcrumbs: [])
    @breadcrumbs = breadcrumbs
  end

  private

  attr_accessor :breadcrumbs
end
