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

  def render_summary_td(room_calendar, room_no)
    # td_bgcolors = ["lightcyan", "lightblue", "palegreen", "lightyellow", "lightpink", "lavender" ,"lightgray", "lightgreen", "yellow", "lightskyblue"]
    room_hash = room_calendar.get_room_hash(room_no)
    if room_hash.empty?
      content_tag(:td, "")
    else
      summary = room_hash["summary"].presence
      order_id = (room_hash["order_id"].present?) ? room_hash["order_id"] : 0
      index = (room_hash["order_id"].present?) ? room_hash["order_id"]%10 : 0
      # content_tag(:td, summary, bgcolor: get_color(index))
      # content_tag(:td, link_to(summary, order_path(order_id)), bgcolor: get_color(index))
      content_tag(:td, link_to(summary, order_path(order_id), remote: true), bgcolor: get_color(index))
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
