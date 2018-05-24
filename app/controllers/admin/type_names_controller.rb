class Admin::TypeNamesController < ApplicationController

  def index
    @type_name = TypeName.all.last(15).reverse
    @new_type_name = TypeName.new
  end

	def create
  	@type_new = TypeName.new(type_params)
  	if @type_new.save
  		redirect_to admin_recommends_path
  	else
  		render 'index'
  	end
  end

  def edit
    @type_names = Genre.all.last(15).reverse
    @new_type_name = Genre.find(params[:id])
  end

  def update
    @type_name = Genre.find(params[:id])
    @type_name.update(type_params)
    redirect_to admin_type_names_path
  end

  def destroy
    @type_name = Genre.find(params[:id])
    @type_name.delete
    redirect_to admin_type_names_path
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @type_names = Genre.where("name LIKE ?", "%#{seach_val}%")
      render :json => @type_names
    end
  end

  private

  	def type_params
  		params.require(:type_name).permit(:name)
  	end
end
