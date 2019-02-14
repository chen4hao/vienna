class StatisticsController < ApplicationController

  # 統計報表 -> 日報
  def daily
    @search_date = Date.today
    @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?
    @daily_statistics = calculate_daily_satistics(@search_date)

    # @statistics = Statistic.find_by(day: @search_date)
    # @room_items = OrderItem.where("type='RoomItem' AND day = ?", @search_date)
  end

  private

  # 計算每日客房統計數字
  def calculate_daily_satistics(search_date)
    chalet_cash, chalet_credit, chalet_total, chalet_count = 0, 0, 0, 0
    villa_cash, villa_credit, villa_total, villa_count = 0, 0, 0, 0
    daily_cash, daily_credit, daily_total, daily_count = 0, 0, 0, 0
    chalet_rooms, villa_rooms, total_rooms = 6.0, 7.0, 13.0

    daily_statistics = []
    room_statistics = []

    daily_statistics << search_date

    Room.select(:no).each do | room |
      room_hash = RoomCalendar.find_by(day: search_date).get_room_hash(room.no.to_s)
      if room_hash.size > 0
        cash = room_hash["cash"]
        credit = room_hash["credit_card"]
        total = room_hash["room_total"]

        room_statistics << cash << credit << total
        puts "room: no[#{room.no}], cash[#{cash}], credit[#{credit}], total[#{total}]"

        case room.no.to_s
        when "105", "301", "302", "303", "305", "306"
          chalet_cash  += cash
          chalet_credit+= credit
          chalet_total += total
          chalet_count += 1
        else
          villa_cash   += cash
          villa_credit += credit
          villa_total  += total
          villa_count  += 1
        end

        daily_cash   += cash
        daily_credit += credit
        daily_total  += total
        daily_count  += 1

      else
        room_statistics << 0 << 0 << 0
      end
    end

    daily_ratio = 100* (daily_count / total_rooms)
    daily_statistics << daily_cash << daily_credit << daily_total
    # puts "daily: no[#{daily_count}], cash[#{daily_cash}], credit[#{daily_credit}], total[#{daily_total}], ratio[#{daily_ratio.round(2)}]"

    chalet_ratio = 100* (chalet_count / chalet_rooms)
    daily_statistics << chalet_cash << chalet_credit << chalet_count << chalet_ratio.round(1)
    # puts "chalet: no[#{chalet_count}], cash[#{chalet_cash}], credit[#{chalet_credit}], ratio[#{chalet_ratio.round(2)}]"

    villa_ratio = 100* (villa_count / villa_rooms)
    daily_statistics << villa_cash << villa_credit << villa_total << villa_ratio.round(1)
    # puts "villa: no[#{villa_count}], cash[#{villa_cash}], credit[#{villa_credit}], ratio[#{villa_ratio.round(2)}]"
    daily_statistics << daily_ratio.round(1)
    daily_statistics +=  room_statistics

    # puts daily_statistics
    # puts room_statistics
    daily_statistics
  end


end
