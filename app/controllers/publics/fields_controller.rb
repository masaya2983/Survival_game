class Publics::FieldsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def show
    @field = Field.find(params[:id])

    unless ViewCount.find_by(user_id: current_user.id, book_id: @field_detail.id)
      current_user.view_counts.create(field_id: @field_detail.id)
    end
    @field_comment = FieldComment.new
  end

  def index
    @fields = Field.all

  if params[:latest]
      @fields = Field.latest.page(params[:page]).per(10)
  elsif params[:old].present?
      @fields=Field.old.page(params[:page]).per(10)
  else
      @fields = Field.all.page(params[:page]).per(10)
  end
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
    @field = Field.find(params[:id])
    @field.destroy
    redirect_to fields_path
  end

  private

  def field_params
    params.require(:field).permit(:name, :body,:image,:status, :review, :star, :category_id)
  end

  def ensure_correct_customer
    @field = Field.find(params[:id])
    unless @field.field == current_customer
      redirect_to fields_path
    end
  end
end
