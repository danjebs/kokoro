# frozen_string_literal: true

class Forms::AutoSelect < BaseComponent
  def initialize(model:, field:, url:, options:, value:, include_blank: false)
    @model = model
    @field = field
    @url = url
    @options = options
    @value = value
    @include_blank = include_blank
  end

  private

  attr_accessor :model, :field, :url, :options, :value, :include_blank
end
