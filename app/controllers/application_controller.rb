class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def check_authorized(record, user)
    redirect_to root_path && return unless record.user == user
  end

end
