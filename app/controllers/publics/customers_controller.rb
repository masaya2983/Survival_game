class Publics::CustomersController < ApplicationController
   before_action :authenticate_customer!
  before_action :ensure_correct_customer!, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @fields = @customer.fields
    @field = Field.new
  end

  def index
   @customers = Customer.all
    @field = Field.new
  end

  def edit
     @customer = Customer.find(params[:id])
  end

  def update
     @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
 def check
   @customer = current_customer
 end

 def withdrawal
   @customer = current_customer
    #is_deletedカラムをtrueに変更することにより削除フラグを立てる
  @customer.update(is_deleted: true)
  reset_session
  redirect_to root_path
 end


  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
