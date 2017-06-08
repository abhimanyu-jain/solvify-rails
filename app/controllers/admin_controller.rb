class AdminController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :authenticate_user!
  before_action :check_admin_user

  def show_all
    @orders = Order.all
    #render json: @orders.to_json
  end

  def changeStatus
    id = params[:id]
    newStatus = params[:newStatus]
    @order = Order.find(id)
    @order.status = newStatus
    @order.save
    redirect_to :dashboard
  end

  private

  def check_admin_user
    if current_user.type != 'Admin'
      redirect_to '/users/sign_in'
    end
  end
end
