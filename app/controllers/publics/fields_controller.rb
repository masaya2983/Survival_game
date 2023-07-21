class Publics::FieldsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def show
    @field = Field.find(params[:id])
    @field_comment = FieldComment.new
  end

  def index
    @fields = Field.all.order(params[:sort])
    @field = Field.new
  end

  def create
    @field = Field.new(field_params)
    @field.customer_id = current_customer.id
    tag_list = params[:field][:tag_name].split(',')
    if @field.save
      @field.save_tags(tag_list)
      redirect_to field_path(@field), notice: "You have created field successfully."
    else
      @fields = Field.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @field.update(field_params)
      redirect_to field_path(@field), notice: "You have updated field successfully."
    else
      render "edit"
    end
  end

  def destroy
    @field.destroy
    redirect_to fields_path
  end

  private

  def field_params
    params.require(:field).permit(:name, :body, :rate)
  end

  def ensure_correct_customer
    @field = Field.find(params[:id])
    unless @field.field == current_customer
      redirect_to fields_path
    end
  end
end
