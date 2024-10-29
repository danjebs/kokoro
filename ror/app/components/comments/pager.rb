class Comments::Pager < BaseComponent
  def initialize(commentable:, pagy:)
    @commentable = commentable
    @pagy = pagy
  end

  private

  attr_reader :commentable, :pagy
end
