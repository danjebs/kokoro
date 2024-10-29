# frozen_string_literal: true

class Layout::Sidebar < BaseComponent
  def initialize(links: [])
    @links = links
  end

  private

  attr_accessor :links
end
