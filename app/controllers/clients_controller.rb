class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find params[:id]
  end

  def new
    @client = Client.new
    @client.pets.build
  end

  def edit
    @client = Client.find params[:id]
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to client_path(@client)
    else
      render ‘new’
    end
  end

  def update
    @client = Client.find params[:id]
    respond_to do |format|
      if @client.update_attributes(client_params)
        format.html { redirect_to client_path(@client), notice: 'Cliente actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @client = Client.find params[:id]
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente eliminado correctamente.' }
    end
  end

  private
  def client_params
    params.require(:client).permit(:name, :phone, :email, pets_attributes: [:id, :name, :race, :birthdate, :client_id, :_destroy])
  end
end
