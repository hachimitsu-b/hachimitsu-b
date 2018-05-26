class User::CdsController < ApplicationController
  def show
  	if Cd.find_by(id: params[:id])

  	@cd = Cd.find(params[:id])

  	else
  		redirect_to cds_path
  	end


  end

  def index
    # 最新のシングルを取得
    @new_single_cds = Cd.where('release_day < ? and single_album = true', Time.now).last(6)
    # 最新のアルバムを取得
    @new_album_cds = Cd.where('release_day < ? and single_album = false', Time.now).last(6)
    # 1週間で発売されたシングルを取得
    new_single_rank = Cd.where('release_day < ? and release_day > ? and single_album = true', Time.now, Time.now.ago(7.days))
    @most_singles = new_single_rank.first(3)
    new_single_rank.each do |single|

    end
    @cds = Cd.search(params[:search])
  end

  # def seach
  #   if params[:seach].present?
  #     seach_val = params[:seach]
  #     @cds = Cd.where("name LIKE ?", "%#{seach_val}%")
  #      render :json => @cds
  #   end
  # end

  private

    def  cd_params
      params.require(:cd).permit(:name)
    end
end
