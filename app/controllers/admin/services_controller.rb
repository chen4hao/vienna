class Admin::ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  before_action :set_service, only: [:edit, :update, :destroy]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.create(service_params)
    if @service.save
      redirect_to admin_services_path, notice: "新增服務(#{@service.name})成功"
    else
      render :new
    end
  end

  def destroy
    service_name = @service.name
    @service.destroy
    redirect_to admin_services_path, alert: "服務(#{service_name})已刪除!"
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to admin_services_path, notice: "更新服務(#{@service.name})成功"
    else
      render :edit
    end

  end

  private
  def service_params
    params.require(:service).permit(:name, :list_price, :custom_price, :category)
  end

  def set_service
    @service = Service.find(params[:id])
  end

end
