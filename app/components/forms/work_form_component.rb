# frozen_string_literal: true

class Forms::WorkFormComponent < ViewComponent::Base
  def initialize(work:)
    @work = work
  end
end
