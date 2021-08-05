module SubmissionsHelper
  def link_to_submission(submission)
    return link_to id_to_s(submission.id), submission
  end

  def link_to_submissions(text, args = {})
    filters = {}
    if (args[:user].present?) then filters[:user_id] = args[:user].id end
    if (args[:work].present?) then filters[:work_id] = args[:work].id end
    if (args[:buyer].present?) then filters[:buyer_id] = args[:buyer].id end
    return link_to text, submissions_path(filters)
  end
end
