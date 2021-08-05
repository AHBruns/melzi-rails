# frozen_string_literal: true

class DataTables::FilesCardComponent < ViewComponent::Base
  def initialize(files:)
    @files = files
  end

end
