# frozen_string_literal: true

class Forms::WorkFieldsetComponent < ViewComponent::Base
  def initialize(form:, work:, current_user:)
    @form = form
    @work = work
    @current_user = current_user
  end
end
