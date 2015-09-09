class GenericOrdersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    if session[:city]
      @city = session[:city]
    end
	end

  def new
  end

  def create
    @order =  Order.new(order_params)
    if @order[:origin_of_request] == nil
      @order[:origin_of_request] = @@src
    end
    @order[:service] = @@service
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
    render json: @order.to_json
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
    @@service = params[:service_name]
    redirect_to URI.escape('/'+ @@service)
  end

  def personal
    @@date = params[:date]
    @@slot = params[:slot]
    @@customer_notes = params[:customer_notes]
    @@coupon_code = params[:coupon_code]

    if browser.mobile?
      @@src =  "mobile browser"
    else
      @@src = "desktop browser"
    end
  end

  def plumbing
  end

  def electrical
  end

  def house_cleaning
  end

  def keymaker
  end

  def laundry
  end

  def movers_packers
  end

  def painter
  end

  def pest_control
  end

  def carpenter
  end

  def car_wash
  end

  def computer_repair
  end

  def appliance_repair
  end

  def cook
  end

  def set_city
    session[:city] = params[:cities]
    render :index
  end

  private

  def order_params
    params.permit(:customer_id, :service, :booking_date,:booking_slot,:customer_comments, :name, :address, :phone, :email)
  end

  #@@gurgaon_services = Array.new("Electrical", "Plumbing", "Packers and Movers", "Car Wash", "Pest Control", "Computer Repair", "Appliance Repair", "House Cleaning", "Carpenter", "Cook", "Painter", "Keymaker")
  #@@bangalore_services = Array.new("Electrical", "Plumbing", "Packers and Movers", "Car Wash", "Pest Control", "Computer Repair", "Appliance Repair", "House Cleaning", "Carpenter", "Cook", "Painter", "Keymaker")


  def get_services_list
  end

end
