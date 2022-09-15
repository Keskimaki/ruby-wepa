class RatingsController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :clear_cache, only: [:create, :destroy]

  def index
    @ratings = Rating.all
    @recent_ratings = Rating.recent

    @top_beers = Rails.cache.fetch("beer top 3", expires_in: 1.hour) { Beer.top(3) }
    @top_breweries = Rails.cache.fetch("brewery top 3", expires_in: 1.hour) { Brewery.top(3) }
    @top_styles = Rails.cache.fetch("style top 3", expires_in: 1.hour) { Style.top(3) }
    @top_users = Rails.cache.fetch("user top 3", expires_in: 1.hour) { User.top(3) }
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to ratings_path
  end

  def clear_cache
    expire_fragment("brewerylist")
  end
end
