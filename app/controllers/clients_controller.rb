class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:edit, :update, :destroy, :show]

  # 接待/客戶管理 -> 列出所有客戶
  def index
    if params.has_key?(:name)
      @search_name = params[:name]
      @clients = Client.where('lower(name) LIKE ?', "%#{@search_name.downcase}%")
    else
      @clients = Client.all
    end
  end

  # 接待/客戶管理 -> 依客戶查詢
  def search
    @search_name = params[:search_name] if params.has_key?(:search_name) && params[:search_name].present?
    @search_mobile = params[:search_mobile] if params.has_key?(:search_mobile) && params[:search_mobile].present?

    if @search_name.present? && @search_mobile.present?
      @clients = Client.where('lower(name) LIKE ?', "%#{@search_name.downcase}%").where('lower(mobile) LIKE ?', "%#{@search_mobile.downcase}%")
    elsif @search_name.present?
      @clients = Client.where('lower(name) LIKE ?', "%#{@search_name.downcase}%")
    elsif @search_mobile.present?
      @clients = Client.where('lower(mobile) LIKE ?', "%#{@search_mobile.downcase}%")
    else
      @clients = []
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path , notice: "新增客戶(#{@client.name})成功"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to clients_path , notice: "更新客戶(#{@client.name})成功"
    else
      render :edit
    end
  end

  def destroy
    client_name = @client.name
    @client.destroy
    redirect_to clients_path, alert: "客戶(#{client_name})已刪除!"
  end


  private

  def client_params
    params.require(:client).permit(:name, :sex, :mobile, :country, :id_no, :birthday, :job, :tel, :address, :email, :reminder, :note)
  end

  def set_client
    @client = Client.find(params[:id])
  end



end
