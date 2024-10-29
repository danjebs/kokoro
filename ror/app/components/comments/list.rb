class Comments::List < BaseComponent
  def initialize(commentable:, comments:, pagy:)
    @commentable = commentable
    @comments = comments
    @pagy = pagy
  end

  private

  attr_reader :commentable, :comments, :pagy
end
