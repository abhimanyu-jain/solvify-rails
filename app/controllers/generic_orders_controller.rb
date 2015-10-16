require 'tasks/email'
require 'tasks/sms'

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
      @order[:email] = current_user.email
    else
      @order[:email] = params[:email]
    end

    if browser.mobile?
      @order[:origin_of_request] = "Mobile Browser"
    else
      @order[:origin_of_request] = "Desktop Browser"
    end

    @order[:service] = cookies[:service]
    @order[:initiated_on] = Time.zone.now
    @order[:rating] = 0
    @order[:feedback] = 'nil'
    @order[:amount] = 0
    @order[:vendor_id] = 0
    @order[:status] = 'Initiated'
    @order[:name] = params[:name]
    @order[:address] = params[:address] || (params[:house] + ", " + params[:street] + ", " + (params[:city]?params[:city]:cookies[:city]) + ", " + params[:pincode])
    @order[:phone] = params[:phone]
    @order[:booking_date] = cookies[:date]
    @order[:booking_slot] = cookies[:slot]
    @order[:customer_comments] = cookies[:customer_notes]
    @order[:coupon_code] = cookies[:coupon_code]
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

    sms_message = "Hi "+@order[:name]+", your order has been received. Your order id is : "+@order[:id].to_s+".\n Thank you \n Team Solvify"
    send_sms(@order[:phone], sms_message)
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

  def cancel_order
    super
    redirect_to '/MyOrders'
  end

  def select_service_page
    cookies[:service] = params[:service_name]
    redirect_to URI.escape('/'+ cookies[:service])
  end

  def personal
    cookies[:date] = params[:date]
    cookies[:slot] = params[:slot]
    cookies[:customer_notes] = params[:customer_notes]
    cookies[:coupon_code] = params[:coupon_code]

    if current_user != nil
      params[:customer_id] = current_user.id
      #Find disctinct name+address+phone combos of a user, raw query was the only way to achieve
      sql = "select distinct o.name,o.address,o.phone from (select id,name,address,phone from orders where customer_id="+params[:customer_id].to_s+" order by id desc) as o limit 2"
      @contacts = ActiveRecord::Base.connection.execute(sql)
    end
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
    @today_valid_slots = get_slots(all_slots)
    @all_slots = all_slots
  end

  def orderConfirmation
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

  def all_slots
    return [["10:00 AM - 11:00 AM", "10:00:00"],
            ["11:00 AM - 12:00 PM", "11:00:00"],
            ["12:00 PM - 1:00 PM", "12:00:00"],
            ["1:00 PM - 2:00 PM", "13:00:00"],
            ["2:00 PM - 3:00 PM", "14:00:00"],
            ["3:00 PM - 4:00 PM", "15:00:00"],
            ["4:00 PM - 5:00 PM", "16:00:00"],
            ["5:00 PM - 6:00 PM", "17:00:00"],
            ["6:00 PM - 7:00 PM", "18:00:00"],
            ["7:00 PM - 8:00 PM", "19:00:00"]]
  end

  def get_slots(allSlots)
    current_time = (Time.zone.now + 7200).strftime("%H:%M:%S")
    if current_time < allSlots[0][1]
      return allSlots
    elsif current_time > (allSlots[allSlots.size - 1][1])
      return allSlots
    else
      slots = Array.new
      allSlots.each { |x|
      if x[1] > current_time
        slots << x
      end
      }
      return slots
    end
  end
end