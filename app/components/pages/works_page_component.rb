# frozen_string_literal: true

class Pages::WorksPageComponent < ViewComponent::Base
  def initialize(works:)
    @works = works
  end
end