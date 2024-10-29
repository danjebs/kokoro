module Commentable
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  included do
    has_many :comments, as: :commentable, dependent: :destroy

    def comments_path(page:, limit: 5)
      commentable_comments_path(
        commentable_type: self.class.name,
        commentable_id: self.id,
        page: page,
        limit: limit
      )
    end
  end
end
