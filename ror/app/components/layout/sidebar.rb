# frozen_string_literal: true

class Layout::Sidebar < ViewComponent::Base
  def initialize(links: [])
    @links = links
  end

  private

  attr_accessor :links
end
