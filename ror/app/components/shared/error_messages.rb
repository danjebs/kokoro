class Shared::ErrorMessages < BaseComponent
  def initialize(resource:)
    @resource = resource
  end

  private

  attr_reader :resource
end
