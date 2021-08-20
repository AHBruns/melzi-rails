# frozen_string_literal: true

class Forms::SubmissionFieldsetComponent < ViewComponent::Base
  def initialize(form:, submission:, current_user:, excluded_fields: Set[])
    @form = form
    @submission = submission
    @current_user = current_user
    @excluded_fields = excluded_fields
  end

end
