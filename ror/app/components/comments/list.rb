class Comments::List < ViewComponent::Base
  def initialize(commentable:)
    @commentable = commentable
  end

  private

  attr_reader :commentable
end
