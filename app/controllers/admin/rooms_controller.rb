class Admin::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to admin_rooms_path, notice: "新增房間(#{@room.name})成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to admin_rooms_path, notice: "更新房間(#{@room.name})成功"
    else
      render :edit
    end
  end

  def destroy
    room = "#{@room.no}-#{@room.name}"
    @room.destroy
    redirect_to admin_rooms_path, alert: "服務(#{room})已刪除!"
  end

  private

  def room_params
    params.require(:room).permit(:no, :name, :list_price, :holiday_price, :hotday_price, :weekday_price, :custom_price, :add_bed_fee)
  end

  def set_room
    @room = Room.find(params[:id])
  end




end
