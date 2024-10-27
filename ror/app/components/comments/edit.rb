class Comments::Edit < ViewComponent::Base
  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment
end
