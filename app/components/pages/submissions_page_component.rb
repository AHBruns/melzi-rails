# frozen_string_literal: true

class Pages::SubmissionsPageComponent < ViewComponent::Base
  def initialize(submissions:)
    @submissions = submissions
  end

end
