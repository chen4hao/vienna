class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:edit, :update, :destroy, :show]

  def index
    if params.has_key?(:name)
      @search_name = params[:name]
      @clients = Client.where('lower(name) LIKE ?', "%#{@search_name.downcase}%")
    else
      @clients = Client.all
    end
  end

  def search
    if params.has_key?(:client_name) && params.has_key?(:client_mobile)
      @clients = Client.where('lower(name) LIKE ?', "%#{params[:client_name].downcase}%").where('lower(mobile) LIKE ?', "%#{params[:client_mobile].downcase}%")
    elsif params.has_key?(:client_name)
      @clients = Client.where('lower(name) LIKE ?', "%#{params[:client_name].downcase}%")
    elsif params.has_key?(:client_mobile)
      @clients = Client.where('lower(mobile) LIKE ?', "%#{params[:client_mobile].downcase}%")
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
    params.require(:client).permit(:name, :sex, :mobile, :country, :id_no, :birthday, :job, :tel, :address, :email, :remider, :note)
  end

  def set_client
    @client = Client.find(params[:id])
  end



end
