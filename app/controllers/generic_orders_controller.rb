require 'tasks/email'

class GenericOrdersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    if cookies[:city] != nil
      @city = cookies[:city]
    end
  end

  def new
  end

  def create
    @order = Order.new(order_params)
    if current_user != nil
      @order[:customer_id] = current_user.id
    end

    if browser.mobile?
      @order[:origin_of_request] = "mobile browser"
    else
      @order[:origin_of_request] = "desktop browser"
    end

    @order[:service] = cookies[:service]
    @order[:initiated_on] = DateTime.now
    @order[:rating] = 0
    @order[:feedback] = 'nil'
    @order[:amount] = 0
    @order[:vendor_id] = 0
    @order[:status] = 'Initiated'
    @order[:name] = params[:name]
    @order[:address] = params[:address]
    @order[:phone] = params[:phone]
    @order[:email] = params[:email]
    @order[:booking_date] = @@date
    @order[:booking_slot] = @@slot
    @order[:customer_comments] = @@customer_notes
    @order[:coupon_code] = @@coupon_code
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
  end

  def show
    @order = Order.find(params[:id])
    render json: @order
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      #redirect_to @order
      render json: @order
    else
      #render 'edit'
    end
  end

  def select_service_page
    cookies[:service] = params[:service_name]
    redirect_to URI.escape('/'+ cookies[:service])
  end

  def personal
    @@date = params[:date]
    @@slot = params[:slot]
    @@customer_notes = params[:customer_notes]
    @@coupon_code = params[:coupon_code]
  end

  def orderInfoForm
    temp = URI.decode(request.env['PATH_INFO'])
    temp.slice!(0)
    if cookies[:service] != temp
      cookies[:service] = temp
    end

    if city_to_service == false
      redirect_to :root
    end

    @img = @@img_src[cookies[:service]]["img"]
    @tag_line = @@img_src[cookies[:service]]["tagline"]

  end

  def orderConfirmation()

  end

  def set_city
    cookies[:city] = params[:cities]
    render :index
  end

  def displayUserOrders
    if current_user == nil
      redirect_to :new_user_session
    else
      user_id = current_user.id
      @orders = Order.where("customer_id = " + user_id.to_s)
    end
  end

  private

  def order_params
    params.permit(:customer_id, :service, :booking_date, :booking_slot, :customer_comments, :name, :address, :phone, :email)
  end

  def city_to_service
    if cookies[:city] == 'Gurgaon'
      if cookies[:service] == 'Cook' or cookies[:service] == 'Painter' or cookies[:service] == 'Keymaker'
        return false
      end
    end
    return true
  end

end