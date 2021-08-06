# frozen_string_literal: true

class Forms::LicenseFormComponent < ViewComponent::Base
  def initialize(current_user:, license:)
    @current_user = current_user
    @license = license
  end

end
