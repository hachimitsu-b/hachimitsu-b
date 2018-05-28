class Admin::ArtistsController < ApplicationController
  def index
  	@artists = Artist.where(delete_flag: false).or(Artist.where(delete_flag: nil)).last(15).reverse
    @new_artist = Artist.new
  end

  def create
  	@artist = Artist.create(artist_params)
    redirect_to admin_artists_path
  end

  def edit
	  @artists = Artist.where(delete_flag: false).or(Artist.where(delete_flag: nil)).last(15).reverse
    @new_artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update(artist_params)
    redirect_to admin_artists_path
  end

  def destroy
  	@artist = Artist.find(params[:id])
    @artist.delete_flag = true
    @artist.save
    redirect_to admin_artists_path
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @artists = Artist.where("name_kana LIKE ? and delete_flag = ?", "%#{seach_val}%", false)
      render :json => @artists
    else
      @artists = Artist.last(5)
      render :json => @artists
    end
  end

  private

  	def  artist_params
      params.require(:artist).permit(:name, :name_kana)
    end
end
