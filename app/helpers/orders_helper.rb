module OrdersHelper

  def render_order_state(order)
    I18n.t("orders.order_state.#{order.aasm_state}")
  end

end
