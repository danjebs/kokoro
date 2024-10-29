class Comments::New < BaseComponent
  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment
end
