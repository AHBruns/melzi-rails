# frozen_string_literal: true

class Misc::SubmissionStatusBadgeComponent < ViewComponent::Base
  def initialize(submission:)
    @submission = submission
  end

end
