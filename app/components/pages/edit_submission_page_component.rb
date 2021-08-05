# frozen_string_literal: true

class Pages::EditSubmissionPageComponent < ViewComponent::Base
  def initialize(current_user:, submission:)
    @current_user = current_user
    @submission = submission
  end

end
