class Admin::RecommendsController < ApplicationController
  def index
  	@type_names = TypeName.all
  	@recommend = Recommend.new
  	@cds = Cd.last(10)
  end

  def create
  	@recommend = Recommend.new(recommend_params)
  	if @recommend.save
  		redirect_to admin_recommend_path
  	else
  		@type_names = TypeName.all
  		render 'index'
  	end
  end

  private

  	def recommend_params
  		params.require(:recommend).permit(:recomend_type, :cd_id)
  	end
end
