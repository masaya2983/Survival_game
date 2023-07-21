class Publics::CustomersController < ApplicationController
   before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @fields = @customer.fields
    @field = Field.new
  end

  def index
   @customer = Customer.all
    @field = Field.new
  end

  def edit
  end

  def update
    if @customer.update(user_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
