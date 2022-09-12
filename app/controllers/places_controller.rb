class PlacesController < ApplicationController

  def show
    @place = BeermappingApi.get_place_by_id(params[:id]).first
    render :show
  end

  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end
end
