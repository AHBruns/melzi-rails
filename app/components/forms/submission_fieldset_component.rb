# frozen_string_literal: true

class Forms::SubmissionFieldsetComponent < ViewComponent::Base
  def initialize(form:, submission:, current_user:, excluded_fields: Set[], errors: {}, errors_key_prefix: '')
    @form = form
    @submission = submission
    @current_user = current_user
    @excluded_fields = excluded_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end

end
