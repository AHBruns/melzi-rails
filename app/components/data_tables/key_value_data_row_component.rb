# frozen_string_literal: true

class DataTables::KeyValueDataRowComponent < ViewComponent::Base
  def initialize(key:, value:)
    @key = key
    @value = value
  end
end
