module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  def configure_permitted_parameters
    #註冊頁面
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :title])
    #修改註冊資料
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :title])
  end
end
