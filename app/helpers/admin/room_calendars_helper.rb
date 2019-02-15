module Admin::RoomCalendarsHelper

  def render_tr_class(calendar)
    case calendar.day_mode
      when 1
        "success"
      when 2
        "warning"
      when 3
        "danger"
      else
        ""
    end
  end

  def render_day_mode(calendar)
    case calendar.day_mode
      when 1
        "寒暑假旺日"
      when 2
        "週六假日/連假"
      when 3
        "元旦/春節連假"
      else
        "平日"
    end
  end

end
