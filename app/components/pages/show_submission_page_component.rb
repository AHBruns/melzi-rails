# frozen_string_literal: true

class Pages::ShowSubmissionPageComponent < ViewComponent::Base
  def initialize(submission:)
    @submission = submission
  end

end
