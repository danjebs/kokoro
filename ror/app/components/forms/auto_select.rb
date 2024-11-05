# frozen_string_literal: true

class Forms::AutoSelect < BaseComponent
  def initialize(record:, field:, options:, include_blank: false)
    @record = record
    @field = field
    @options = options
    @include_blank = include_blank
  end

  private

  attr_accessor :record, :field, :options, :include_blank
end
