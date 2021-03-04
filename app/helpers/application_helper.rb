module ApplicationHelper
  def check_authorized_user(record, user)
    record.user == current_user
  end
end
