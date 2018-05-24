class User::CdsController < ApplicationController
  def show
  	if Cd.find_by(id: params[:id])

  	@cd = Cd.find(params[:id])

  	else
  		redirect_to cds_path
  	end


  end

  def index
    @cd = Cd.all
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @cds = Cd.where("name LIKE ?", "%#{seach_val}%")
      render :json => @cds
    end
  end

  private

    def  cd_params
      params.require(:cd).permit(:name)
    end
end
