# frozen_string_literal: true

class Pages::NewLicensePageComponent < ViewComponent::Base
  def initialize(current_user:, license:)
    @current_user = current_user
    @license = license
  end

end
