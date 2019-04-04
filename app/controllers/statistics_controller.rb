class StatisticsController < ApplicationController
  before_action :set_search_date, only: [:daily, :weekly, :monthly, :yearly]

  # 統計報表 -> 日報
  def daily
    @daily_statistics = calculate_daily_satistics(@search_date)
  end

  # 統計報表 -> 週報
  def weekly
    @weekly_statistics = []
    @statistic_summary = []
    get_weekly_statistics(@search_date, @weekly_statistics, @statistic_summary)
  end

  # 統計報表 -> 月報
  def monthly
    @monthly_statistics = []
    @statistic_summary = []
    get_monthly_statistics(@search_date, @monthly_statistics, @statistic_summary)
  end

  # 統計報表 -> 年報
  def yearly
    search_year = @search_date.year
    year_cash, year_credit, year_total, year_count = 0, 0, 0, 0
    total_rooms = 13.0

    @yearly_statistics = []
    @statistic_summary = []
    1.upto(12) do |month|
      monthly_date = Date.new(search_year, month, 1)
      monthly_statistics = []
      monthly_summary = []

      monthly_summary << monthly_date.strftime("%Y-%m")

      get_monthly_statistics(monthly_date, monthly_statistics, monthly_summary)
      @yearly_statistics << monthly_summary

      year_cash   += monthly_summary[1]
      year_credit += monthly_summary[2]
      year_total  += monthly_summary[3]
      year_count  += monthly_summary[5]
    end

    year_ratio = 100* (year_count / (total_rooms * @yearly_statistics.size))
    @statistic_summary << year_cash << year_credit << year_total << "#{year_ratio.round(1)}%" << year_count
  end

  private

  # def set_search_date
  #   @search_date = Date.today
  #   @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?
  # end

  # 抓取日期區間每週統計數字
  def get_weekly_statistics(day, statistics, summary)
    get_period_statistics(day.beginning_of_week, day.end_of_week, statistics, summary)
  end

  # 抓取日期區間每月統計數字
  def get_monthly_statistics(day, statistics, summary)
    get_period_statistics(day.beginning_of_month, day.end_of_month, statistics, summary)
  end

  # 抓取日期區間每日統計數字
  def get_period_statistics(start_date, end_date, period_statistics, summary)
    period_cash, period_credit, period_total, period_count = 0, 0, 0, 0
    total_rooms = 13.0

    start_date.upto(end_date) do |day|
      daily_statistics = calculate_daily_satistics(day)

      period_statistics << daily_statistics
      period_cash   += daily_statistics[1]
      period_credit += daily_statistics[2]
      period_total  += daily_statistics[3]
      period_count  += daily_statistics[6] + daily_statistics[10]
    end

    period_ratio = 100* (period_count / (total_rooms * period_statistics.size))
    summary << period_cash << period_credit << period_total << "#{period_ratio.round(1)}%" << period_count

  end

  # 計算每日客房統計數字
  def calculate_daily_satistics(search_date)
    chalet_cash, chalet_credit, chalet_total, chalet_count = 0, 0, 0, 0
    villa_cash, villa_credit, villa_total, villa_count = 0, 0, 0, 0
    daily_cash, daily_credit, daily_total, daily_count = 0, 0, 0, 0
    chalet_rooms, villa_rooms, total_rooms = 6.0, 7.0, 13.0

    daily_statistics = []
    room_statistics = []

    # daily_statistics << render_day(search_date)
    daily_statistics << search_date

    Room.select(:no).order("created_at").each do | room |
      room_hash = RoomCalendar.find_by(day: search_date).get_room_hash(room.no.to_s)
      if room_hash.size > 0
        cash = room_hash["cash"]
        credit = room_hash["credit_card"]
        total = room_hash["room_total"]

        room_statistics << cash << credit << total
        # puts "room: no[#{room.no}], cash[#{cash}], credit[#{credit}], total[#{total}]"

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
    daily_statistics << chalet_cash << chalet_credit << chalet_count << "#{chalet_ratio.round(1)}%"
    # puts "chalet: no[#{chalet_count}], cash[#{chalet_cash}], credit[#{chalet_credit}], ratio[#{chalet_ratio.round(2)}]"

    villa_ratio = 100* (villa_count / villa_rooms)
    daily_statistics << villa_cash << villa_credit << villa_count << "#{villa_ratio.round(1)}%"
    # puts "villa: no[#{villa_count}], cash[#{villa_cash}], credit[#{villa_credit}], ratio[#{villa_ratio.round(2)}]"
    daily_statistics << "#{daily_ratio.round(1)}%"
    daily_statistics +=  room_statistics

    # puts daily_statistics
    # puts room_statistics
    daily_statistics
  end


end
