# frozen_string_literal: true

class Pages::ShowLicensePageComponent < ViewComponent::Base
  def initialize(license:)
    @license = license
  end

end
