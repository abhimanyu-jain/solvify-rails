class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @order = Order.new(order_params)
    @order[:origin_of_request] = "Mobile App"
    @order[:initiated_on] = DateTime.now
    @order[:rating] = 0
    @order[:feedback] = 'nil'
    @order[:amount] = 0
    @order[:vendor_id] = 0
    @order[:status] = 'Initiated'

    @order.save
    to = @order[:email]
    from = "donotreply@solvify.in"
    subject = "Your order has been received at Solvify"
    body = "Dear " + @order[:name] + ",<br/><br/>" + "Your order id is : " + @order[:id].to_s +
        ".<br/><br/> Your order details are : " +
        "<br/>Service : " + @order[:service] +
        "<br/>Booking Date and Slot : " + @order["booking_slot"].strftime("%l:%M%p") + " " + @order["booking_date"].to_s +
        "<br/><br/>Thank You" +
        "<br/>Team Solvify" +
        "<br/>8884253299"
    sendMail to, from, subject, body
    render json: @order
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order[:status] = "Cancelled"
    @order.save
    to = @order[:email]
    from = "donotreply@solvify.in"
    subject = "Your order has been cancelled"
    body = "Dear " + @order[:name] + ",<br/><br/>" + "Your order id number : " + @order[:id].to_s + "has been cancelled as per your request."
        "<br/><br/>Thank You" +
        "<br/>Team Solvify" +
        "<br/>8884253299"
    sendMail to, from, subject, body

    render json: @order
  end

  def get_all
    @orders = Order.where("customer_id = " + params[:customer_id])
    render json: @orders
  end

  private

  def order_params
    params.permit(:customer_id, :service, :booking_date, :booking_slot, :customer_comments, :name, :address, :phone, :email, :coupon_code)
  end

end