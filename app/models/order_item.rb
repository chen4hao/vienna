class OrderItem < ApplicationRecord
  belongs_to :order

  after_destroy :clear_room_calendar
  after_save :update_room_calendar

  def clear_room_calendar
    if type == "RoomItem"
      room_no = name[0, 3]
      room_calendar = RoomCalendar.find_by(day: day)
      if room_calendar.present?
        case room_no
          when "301"
            room_calendar.update(r301: "")
          when "302"
            room_calendar.update(r302: "")
          when "303"
            room_calendar.update(r303: "")
          when "305"
            room_calendar.update(r305: "")
          when "306"
            room_calendar.update(r306: "")
          when "101"
            room_calendar.update(r101: "")
          when "102"
            room_calendar.update(r102: "")
          when "103"
            room_calendar.update(r103: "")
          when "105"
            room_calendar.update(r105: "")
          when "201"
            room_calendar.update(r201: "")
          when "202"
            room_calendar.update(r202: "")
          when "203"
            room_calendar.update(r203: "")
          when "205"
            room_calendar.update(r205: "")
          else
            puts ""
        end
      end
    end
  end

  def generate_room_hash
    room_hash = {}
    room_hash.store("room_price", price)
    bed_fee = add_bed_fee * add_bed_no
    room_hash.store("bed_fee", bed_fee)
    room_total = price + bed_fee
    room_hash.store("room_total", room_total)
    credit_card = order.credit_card
    credit_card = room_total if credit_card > room_total
    room_hash.store("credit_card", credit_card)
    cash = room_total - credit_card
    room_hash.store("cash", cash)
    room_hash
  end

  def update_room_calendar
    if type == "RoomItem"
      room_no = name[0, 3]
      total_people = adult_no.to_i + kid_no.to_i + baby_no.to_i
      country =  ( order.country.blank? || order.country == "台灣" ) ? "" : "[#{order.country}]"

      summary = "#{order.name} #{country} (#{order.mobile}) x#{total_people}"
      room_hash = generate_room_hash
      room_hash.store("summary", summary)

      room_calendar = RoomCalendar.find_by(day: day)
      if room_calendar.present?
        case room_no
          when "301"
            room_calendar.update(r301: room_hash)
          when "302"
            room_calendar.update(r302: room_hash)
          when "303"
            room_calendar.update(r303: room_hash)
          when "305"
            room_calendar.update(r305: room_hash)
          when "306"
            room_calendar.update(r306: room_hash)
          when "101"
            room_calendar.update(r101: room_hash)
          when "102"
            room_calendar.update(r102: room_hash)
          when "103"
            room_calendar.update(r103: room_hash)
          when "105"
            room_calendar.update(r105: room_hash)
          when "201"
            room_calendar.update(r201: room_hash)
          when "202"
            room_calendar.update(r202: room_hash)
          when "203"
            room_calendar.update(r203: room_hash)
          when "205"
            room_calendar.update(r205: room_hash)
          else
            puts ""
        end
      end
    end
  end

end


class RoomItem < OrderItem
end

class ServiceItem < OrderItem
end
