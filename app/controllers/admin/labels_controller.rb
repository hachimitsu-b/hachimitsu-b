class Admin::LabelsController < ApplicationController
   def index
  	@labels = Label.all.last(15).reverse
    @new_label = Label.new
  end

  def create
  	@label = Label.create(label_params)
    redirect_to admin_labels_path
  end

  def edit
	  @labels = Label.all.last(15).reverse
    @new_label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    @label.update(label_params)
    redirect_to admin_labels_path
  end

  def destroy
  	@label = Label.find(params[:id])
    @label.delete
    redirect_to admin_labels_path
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @labels = Label.where("name LIKE ?", "%#{seach_val}%")
      render :json => @labels
    end
  end

  private

  	def  label_params
      params.require(:label).permit(:name, :name_kana)
    end
end
