class Admin::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    # flash[:notice] = "成功顯示訊息～"
  end
end
