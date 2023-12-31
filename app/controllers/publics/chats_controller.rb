class Publics::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  def show
    @customer = Customer.find(params[:id])
    rooms = current_customer.customer_rooms.pluck(:room_id)
    customer_rooms = UserRoom.find_by(customer_id: @customer.id, room_id: rooms)

    unless customer_rooms.nil?
      @room = customer_rooms.room
    else
      @room = Room.new
      @room.save
      CustomerRoom.create( customer_id: current_customerid, room_id: @room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  def create
    @chat = current_customer.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = Customer.find(params[:id])
    unless current_customer.following?(customer) && customer.following?(current_customer)
      redirect_to fields_path
    end
  end
end
