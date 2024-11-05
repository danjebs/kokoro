# frozen_string_literal: true

class Forms::EditableContent < BaseComponent
  # def initialize(model:, field:, url:, options:, value:, include_blank: false)
  def initialize(record:, field:)
    @record = record
    # @model = model
    @field = field
    # @url = url
    # @options = options
    # @value = value
    # @include_blank = include_blank
  end

  private

  attr_accessor :record, :field
  # attr_accessor :model, :field, :url, :options, :value, :include_blank
end
