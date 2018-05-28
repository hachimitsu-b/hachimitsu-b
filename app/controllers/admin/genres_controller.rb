class Admin::GenresController < ApplicationController
  def index
  	@genres = Genre.where(delete_flag: false).or(Genre.where(delete_flag: nil)).last(15).reverse
    @new_genre = Genre.new
  end

  def create
  	@genre = Genre.create(genre_params)
    redirect_to admin_genres_path
  end

  def edit
	  @genres = Genre.where(delete_flag: false).or(Genre.where(delete_flag: nil)).last(15).reverse
    @new_genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  def destroy
  	@genre = Genre.find(params[:id])
    @genre.delete_flag = true
    @genre.save
    redirect_to admin_genres_path
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @genres = Genre.where("name_kana LIKE ? and delete_flag = ?", "%#{seach_val}%", false)
      render :json => @genres
    else
      @genres = Genre.last(10)
      render :json => @genres
    end
  end

  private

  	def  genre_params
      params.require(:genre).permit(:name, :name_kana)
    end
end
