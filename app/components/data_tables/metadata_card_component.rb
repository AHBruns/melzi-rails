# frozen_string_literal: true

class DataTables::MetadataCardComponent < ViewComponent::Base
  def initialize(object:)
    @object = object
  end
end
