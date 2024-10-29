class Comments::Listing < BaseComponent
  with_collection_parameter :comment

  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment

  def time_display
    [
      comment.updated_at > comment.created_at ? "Edited" : "",
      date_display(comment.updated_at)
    ].join(" ")
  end

  def date_display(date)
    if date > Date.current
      "#{time_ago_in_words(date)} ago"
    elsif date.year == Date.current.year
      date.strftime("%b %d")
    else
      date.strftime("%b %d, %Y")
    end
  end
end
