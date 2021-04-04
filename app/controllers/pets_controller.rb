class PetsController < ApplicationController
  before_action :find_client

  def index
    @pets = @client.pets
  end

  def show
    @pet = Pet.find(params[:id])   
  end

  def new
    @pet = Pet.new    
  end

  def edit
    @pet = Pet.find(params[:id])   
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.client = @client
    respond_to do |format|
      if @pet.save
        format.html { redirect_to client_pet_path(@client, @pet), notice: 'Mascota creada correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @pet = Pet.find params[:id]
    respond_to do |format|
      if @pet.update(pet_params.merge(client: @client))# Se añade el client que se obtuvo en la llamada a find_client
        format.html { redirect_to client_pet_path(@client, @pet), notice: 'Macota actualizada correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pet = Pet.find params[:id]
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to client_pets_url, notice: 'Mascota Eliminada correctamente.' }
    end
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :race, :birthdate, pet_histories_attributes: [:id, :weight, :heigth, :description, :pet_id, :_destroy])
  end

  def find_client
    @client = Client.find params[:client_id]
  end

end
