class Admin::RecommendsController < ApplicationController
  def index
  	@type_names = TypeName.all
  	@recommend = Recommend.new
  	@cds = Cd.last(10)
  end

  def create
  	@recommend = Recommend.new(recommend_params)
  	if @recommend.save
  		redirect_to admin_recommends_path
  	else
  		@type_names = TypeName.all
  		@cds = Cd.last(10)
  		render 'index'
  	end
  end

  def edit
  	@type_names = TypeName.all
  	@recommend = Recommend.find(params[:id])
  	@cds = Cd.last(10)
  end


  def update
  	@recommend = Recommend.find(params[:id])
  	if @recommend.update(recommend_params)
  		redirect_to admin_recommends_path
  	else
  		@type_names = TypeName.all
  		@cds = Cd.last(10)
  		render 'edit'
  	end
  end

  def destroy
  	@recommend = Recommend.find(params[:id])
    @recommend.delete
    redirect_to admin_recommends_path
  end

  private

  	def recommend_params
  		params.require(:recommend).permit(:recommend_type, :cd_id)
  	end
end
