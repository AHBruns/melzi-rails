module BuyersHelper
  def link_to_buyer(buyer)
    return link_to buyer.name.present? ? buyer.name : id_to_s(buyer.id), buyer
  end

  def link_to_buyers(text, args = {})
    filters = {}
    if (args[:user].present?) then filters[:user_id] = args[:user].id end
    return link_to text, buyers_path(filters)
  end
end
