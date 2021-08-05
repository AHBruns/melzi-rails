module LicensesHelper
  def link_to_license(license)
    return link_to id_to_s(license.id), license
  end

  def link_to_licenses(text, args = {})
    filters = {}
    if (args[:user].present?) then filters[:user_id] = args[:user].id end
    if (args[:work].present?) then filters[:work_id] = args[:work].id end
    if (args[:contract].present?) then filters[:contract_id] = args[:contract].id end
    return link_to text, licenses_path(filters)
  end
end
