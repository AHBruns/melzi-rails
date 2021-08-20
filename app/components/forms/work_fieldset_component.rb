# frozen_string_literal: true

class Forms::WorkFieldsetComponent < ViewComponent::Base
  def initialize(form:, work:, current_user:, excluded_fields: Set[])
    @form = form
    @work = work
    @current_user = current_user
    @excluded_fields = excluded_fields
  end
end
