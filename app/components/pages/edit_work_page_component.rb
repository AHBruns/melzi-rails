# frozen_string_literal: true

class Pages::EditWorkPageComponent < ViewComponent::Base
  def initialize(work:)
    @work = work
  end

end
