class HomeController < ApplicationController
  def show
    @my_computers = Item.where user: current_user
  end
end
