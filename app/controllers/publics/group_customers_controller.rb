class Publics::GroupCustomersController < ApplicationController
   before_action :authenticate_user!

  def create
    group_customer = current_customer.group_customers.new(group_id: params[:group_id])
    group_customer.save
    redirect_to request.referer
  end

  def destroy
    group_customer = current_customer.group_customers.find_by(group_id: params[:group_id])
    group_customer.destroy
    redirect_to request.referer
  end

end
