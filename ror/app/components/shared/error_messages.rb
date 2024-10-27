class Shared::ErrorMessages < ViewComponent::Base
  def initialize(resource:)
    @resource = resource
  end

  private

  attr_reader :resource
end
