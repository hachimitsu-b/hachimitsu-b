class Admin::TypeNamesController < ApplicationController
	def create
  	@type_new = TypeName.new(type_params)
  	if @type_new.save
  		redirect_to admin_recommends_path
  	else
  		render 'index'
  	end
  end

  private

  	def type_params
  		params.require(:type_name).permit(:name)
  	end
end
