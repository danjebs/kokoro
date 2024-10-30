# frozen_string_literal: true

class Layout::SideNav < BaseComponent
  def initialize(links: [])
    @links = links
  end

  private

  attr_accessor :links
end
