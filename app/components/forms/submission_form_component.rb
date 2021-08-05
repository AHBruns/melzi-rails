# frozen_string_literal: true

class Forms::SubmissionFormComponent < ViewComponent::Base
  def initialize(current_user:, submission:)
    @current_user = current_user
    @submission = submission
  end

end
