class ApplicationController < ActionController::Base
  include DeviseWhitelist

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end
end
