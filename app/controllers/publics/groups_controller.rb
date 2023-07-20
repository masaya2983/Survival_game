class Publics::GroupsController < ApplicationController

  def new
    @group =Group.new
  end

  def index
    @book = Book.new
    @groups = Group.all
  end
end
