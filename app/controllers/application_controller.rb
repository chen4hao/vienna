class ApplicationController < ActionController::Base
  include DeviseWhitelist

  # 讓 view 也能用，要掛上helper_method
  helper_method :render_day

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end

  # 顯示"%m-%d (%a)"的日期格式，如：03-01(一)
  def render_day(day)
    # day.strftime("%Y-%m-%d (%a)")
    I18n.l(day, format: :calendar )
  end

end
