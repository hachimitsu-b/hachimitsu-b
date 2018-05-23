class Admin::GenresController < ApplicationController
  def index
  	@genres = Genre.all.last(15).reverse
    @new_genre = Genre.new
  end

  def create
  	@genre = Genre.create(genre_params)
    redirect_to admin_genres_path
  end

  def edit
	  @genres = Genre.all.last(15).reverse
    @new_genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  def destroy
  	@genre = Genre.find(params[:id])
    @genre.delete
    redirect_to admin_genres_path
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @genres = Genre.where("name LIKE ?", "%#{seach_val}%")
      render :json => @genres
    end
  end

  private

  	def  genre_params
      params.require(:genre).permit(:name, :name_kana)
    end
end
