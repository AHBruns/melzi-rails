# frozen_string_literal: true

class Forms::WorkFormComponent < ViewComponent::Base
  def initialize(work:, current_user:)
    @work = work
    @current_user = current_user
  end
end
