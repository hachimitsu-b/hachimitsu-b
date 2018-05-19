class User::CdsController < ApplicationController
  def show
  	if Cd.find_by(id: params[:id])

  	@cd = Cd.find(params[:id])

  	else
  		redirect_to Cds_path
  	end

  end

  def index
  	@cd = Cd.all
  end
end