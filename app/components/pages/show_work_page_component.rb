# frozen_string_literal: true

class Pages::ShowWorkPageComponent < ViewComponent::Base
  def initialize(work:)
    @work = work
  end
end
