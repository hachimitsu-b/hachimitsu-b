class Admin::LabelsController < ApplicationController
   def index
  	@labels = Label.where(delete_flag: false).or(Label.where(delete_flag: nil)).last(15).reverse
    @new_label = Label.new
  end

  def create
  	@label = Label.create(label_params)
    redirect_to admin_labels_path
  end

  def edit
	  @labels = Label.where(delete_flag: false).or(Label.where(delete_flag: nil)).last(15).reverse
    @new_label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    @label.update(label_params)
    redirect_to admin_labels_path
  end

  def destroy
  	@label = Label.find(params[:id])
    @label.delete_flag = true
    @label.save
    redirect_to admin_labels_path
  end

  def seach
    if params[:seach].present?
      seach_val = params[:seach]
      @labels = Label.where("name_kana LIKE ? and delete_flag = ?", "%#{seach_val}%", false)
      render :json => @labels
    else
      @labels = Label.last(5)
      render :json => @labels
    end
  end

  private

  	def  label_params
      params.require(:label).permit(:name, :name_kana)
    end
end
