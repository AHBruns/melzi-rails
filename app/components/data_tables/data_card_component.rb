# frozen_string_literal: true

class DataTables::DataCardComponent < ViewComponent::Base
  renders_many :data_rows, DataTables::KeyValueDataRowComponent

  def initialize(title: nil)
    @title = title
  end
end