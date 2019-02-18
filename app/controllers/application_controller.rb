class ApplicationController < ActionController::Base
  include DeviseWhitelist

  # 讓 view 也能用，要掛上helper_method
  helper_method :render_day
  helper_method :render_fullday

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

  # 顯示"%m-%d (%a)"的日期格式，如：03-01(一)
  def render_fullday(day)
    I18n.l(day, format: :full )
  end

  private

  # 設定搜尋日期，預設為今日
  def set_search_date
    @search_date = Date.current
    @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?
  end

end
