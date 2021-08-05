module WorksHelper
  def link_to_work(work)
    return link_to work.title, work
  end

  def link_to_works(text, args = {})
    filters = {}
    if (args[:user].present?) then filters[:user_id] = args[:user].id end
    return link_to text, works_path(filters)
  end
end
