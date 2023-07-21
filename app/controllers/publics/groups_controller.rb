class Publics::GroupsController < ApplicationController

  def new
    @group =Group.new
  end

  def index
    @field = Field.new
    @groups = Group.all
  end
end
