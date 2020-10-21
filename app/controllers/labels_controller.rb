class LabelsController < ApplicationController
  # before_action :set_label, only: [:edit, :update, :destroy]

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to root_path, notice: '新しいラベルを作成しました'
    else
      render :new
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  # def set_label
  #   @label = Label.find(params[:id])
  # end
end
