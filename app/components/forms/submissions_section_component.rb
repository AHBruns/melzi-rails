# frozen_string_literal: true

class Forms::SubmissionsSectionComponent < ViewComponent::Base
  def initialize(form:, submissions:, current_user:, excluded_fields: Set[], excluded_nested_fields: Set[])
    @form = form
    @submissions = submissions
    @current_user = current_user
    @excluded_fields = excluded_fields
    @excluded_nested_fields = excluded_nested_fields
  end
end
