class Publics::FavoritesController < ApplicationController
  def create
    field = Field.find(params[:book_id])
    @favorite = current_customer.favorites.new(field_id: field.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    field= Field.find(params[:field_id])
    @favorite = current_customer.favorites.find_by(field_id: field.id)
    @favorite.destroy
    render 'replace_btn'
  end
end
