# frozen_string_literal: true

class DataTables::TableComponent < ViewComponent::Base
  def initialize(headers:, rows:, action_headers:)
    @headers = headers
    @rows = rows
    @action_headers = action_headers
  end
end
