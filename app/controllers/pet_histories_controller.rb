class PetHistoriesController < ApplicationController
  before_action :find_pet
  before_action :find_client

  def index
    @pet_histories = @pet.pet_histories
  end

  def show
    @pet_history = PetHistory.find(params[:id])
  end

  def new
    @pet_history = PetHistory.new
  end

  def edit
    @pet_history = PetHistory.find(params[:id])
  end

  def create
    @pet_history = PetHistory.new(pet_history_params)
    @pet_history.pet = @pet
    respond_to do |format|
      if @pet_history.save
        format.html { redirect_to client_pet_pet_history_path(@client, @pet, @pet_history), notice: 'Se creo Consulta Correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @pet_history = PetHistory.find params[:id]
    respond_to do |format|
      if @pet_history.update(pet_history_params.merge(pet: @pet))
        format.html { redirect_to client_pet_pet_histories_path(@client,@pet, @pet_history), notice: 'Consulta Editada Correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pet_history = PetHistory.find params[:id]
    @pet_history.destroy
    respond_to do |format|
      format.html { redirect_to client_pet_pet_histories_url, notice: 'Consulta eliminada correctamente.' }
    end
  end

  private
  def pet_history_params
    params.require(:pet_history).permit(:weight, :heigth, :description, :pet_id)
  end

  def find_pet
    @pet = Pet.find params[:pet_id]
  end

  def find_client
    @client = Client.find params[:client_id]
  end
  
end
