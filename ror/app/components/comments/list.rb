class Comments::List < BaseComponent
  def initialize(commentable:)
    @commentable = commentable
  end

  private

  attr_reader :commentable
end
