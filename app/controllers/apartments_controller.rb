class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[ show edit update destroy ]
  before_action :set_buildings, only: %i[ new create edit update ]

  # GET /apartments or /apartments.json
  def index
    @building = Building.find(params[:building_id])
    @apartments = @building.apartments
  end

  # GET /apartments/1 or /apartments/1.json
  def show
    @building = Building.find(params[:building_id])
  end

  # GET /apartments/new
  def new
    @building = Building.find(params[:building_id])
    @apartment = Apartment.new
  end

  # GET /apartments/1/edit
  def edit
    @building = Building.find(params[:building_id])
  end

  # POST /apartments or /apartments.json
  def create
    building = Building.find(params[:building_id])
    @apartment = Apartment.new(apartment_params.merge(building_id: building.id))

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to building_apartment_path(building, @apartment), notice: "Apartment was successfully created." }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1 or /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: "Apartment was successfully updated." }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1 or /apartments/1.json
  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to apartments_url, notice: "Apartment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end

    def set_buildings
      @buildings = Building.pluck(:name, :id)
    end

    # Only allow a list of trusted parameters through.
    def apartment_params
      params.require(:apartment).permit(:number, :building_id)
    end
end
