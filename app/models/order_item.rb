class OrderItem < ApplicationRecord
  belongs_to :order

  after_destroy :clear_room_calendar
  after_save :update_room_calendar

  def clear_room_calendar
    if type == "RoomItem"
      room_no = name[0, 3]
      case room_no
        when "301"
          RoomCalendar.find_by(day: day).update(r301: "")
        when "302"
          RoomCalendar.find_by(day: day).update(r302: "")
        when "303"
          RoomCalendar.find_by(day: day).update(r303: "")
        when "305"
          RoomCalendar.find_by(day: day).update(r305: "")
        when "306"
          RoomCalendar.find_by(day: day).update(r306: "")
        when "101"
          RoomCalendar.find_by(day: day).update(r101: "")
        when "102"
          RoomCalendar.find_by(day: day).update(r102: "")
        when "103"
          RoomCalendar.find_by(day: day).update(r103: "")
        when "105"
          RoomCalendar.find_by(day: day).update(r105: "")
        when "201"
          RoomCalendar.find_by(day: day).update(r201: "")
        when "202"
          RoomCalendar.find_by(day: day).update(r202: "")
        when "203"
          RoomCalendar.find_by(day: day).update(r203: "")
        when "205"
          RoomCalendar.find_by(day: day).update(r205: "")
        else
          puts ""
      end
    end
  end

  def update_room_calendar
    if type == "RoomItem"
      room_no = name[0, 3]
      total_people = adult_no.to_i + kid_no.to_i + baby_no.to_i
      country = ( order.country == "台灣" ) ? "" : "[#{order.country}]"
      case room_no
        when "301"
          RoomCalendar.find_by(day: day).update(r301: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "302"
          RoomCalendar.find_by(day: day).update(r302: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "303"
          RoomCalendar.find_by(day: day).update(r303: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "305"
          RoomCalendar.find_by(day: day).update(r305: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "306"
          RoomCalendar.find_by(day: day).update(r306: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "101"
          RoomCalendar.find_by(day: day).update(r101: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "102"
          RoomCalendar.find_by(day: day).update(r102: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "103"
          RoomCalendar.find_by(day: day).update(r103: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "105"
          RoomCalendar.find_by(day: day).update(r105: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "201"
          RoomCalendar.find_by(day: day).update(r201: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "202"
          RoomCalendar.find_by(day: day).update(r202: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "203"
          RoomCalendar.find_by(day: day).update(r203: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        when "205"
          RoomCalendar.find_by(day: day).update(r205: "#{order.name}#{country}(#{order.mobile}) x #{total_people}")
        else
          puts ""
      end
    end
  end

end


class RoomItem < OrderItem
end

class ServiceItem < OrderItem
end
