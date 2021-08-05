# frozen_string_literal: true

class Misc::WorkStageBadgeComponent < ViewComponent::Base
  def initialize(work:)
    @work = work
  end

end
