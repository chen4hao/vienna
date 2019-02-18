module DashboardHelper
  def render_system_name
    if ENV['RAILS_ENV'] == 'production'
      "維也納小木屋客房管理系統"
    else
      "Vienna v1.0"
    end
  end
end
