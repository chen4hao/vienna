class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # flash[:notice] = "成功顯示訊息～"
  end
end
