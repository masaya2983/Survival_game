class Publics::FieldsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def show
    @field = Field.find(params[:id])

    @field_comment = FieldComment.new
    @field_comments = FieldComment.all
     if @field.status_private? && @field.customer !=current_customer
      respond_to do |format|
        format.html { redirect_to fields_path, notice: 'このページにはアクセスできません' }
    end
   end
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

    if @field.save
      redirect_to @field
     flash[:notice] = "You have created field successfully."
    else
      @fields = Field.all
      render 'new'
    end
  end

  def new
    @field = Field.new
  end

  def edit
     @field = Field.find(params[:id])
    if @field.customer == current_customer
      render "edit"
    else
        redirect_to fields_path
    end
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
    params.require(:field).permit(:name,:content, :body,:image,:status,:tag_id)
  end

  def ensure_correct_customer
    @field = Field.find(params[:id])
    unless @field.field == current_customer
      redirect_to fields_path
    end
  end
end
