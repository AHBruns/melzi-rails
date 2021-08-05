module ContractsHelper
  def link_to_contract(contract)
    return link_to id_to_s(contract.id), contract
  end

  def link_to_contracts(text, args = {})
    filters = {}
    if (args[:user].present?) then filters[:user_id] = args[:user].id end
    if (args[:buyer].present?) then filters[:buyer_id] = args[:buyer].id end
    if (args[:submission_id].present?) then filters[:submission_id] = args[:submission].id end
    return link_to text, contracts_path(filters)
  end
end
