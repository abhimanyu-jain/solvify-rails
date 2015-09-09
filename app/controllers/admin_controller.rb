class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin_user

  def show_all
    @orders = Order.all
    #render json: @orders.to_json
  end

  private

  def check_admin_user
    if current_user.type != 'Admin'
      redirect_to '/users/sign_in'
    end
  end
end
