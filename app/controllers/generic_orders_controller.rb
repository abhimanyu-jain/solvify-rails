class GenericOrdersController < ApplicationController

  skip_before_action :verify_authenticity_token

  @@img_src = Hash.new
  @@img_src = {
      "Packers And Movers" => {"img" => "11.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Electrical" => {"img" => "1.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Plumbing" => {"img" => "2.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Car Wash" => {"img" => "3.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Laundry" => {"img" => "4.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Computer Repair" => {"img" => "7.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Appliance Repair" => {"img" => "8.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Pest Control" => {
          "img" => "9.png",
          "tagline" => "We perfectly understand how pests can make life truly miserable. Whether you are a business institution, home, hospital or any other place, we offer you timely and expert help."
      },
      "House Cleaning" => {"img" => "10.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Keymaker" => {"img" => "key maker1.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Carpenter" => {"img" => "carpenter.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Cook" => {"img" => "5.png", "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."},
      "Painter" => {
          "img" => "paint.png",
          "tagline" => "Our professional painters are experts. You can count on our fully vetted painters to come prepared with all the proper tools to get the job done right the first time."
      }
  }

  def index
    if cookies[:city] != nil
      @city = cookies[:city]
    end
  end

  def new
  end

  def create
    @order = Order.new(order_params)
    if @order[:origin_of_request] == nil
      @order[:origin_of_request] = @@src
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
    cookies[:service] = params[:service_name]
    redirect_to URI.escape('/'+ cookies[:service])
  end

  def personal
    @@date = params[:date]
    @@slot = params[:slot]
    @@customer_notes = params[:customer_notes]
    @@coupon_code = params[:coupon_code]

    if browser.mobile?
      @@src = "mobile browser"
    else
      @@src = "desktop browser"
    end
  end

  def orderInfoForm
    temp = URI.decode(request.env['PATH_INFO'])
    temp.slice!(0)
    if cookies[:service] != temp
      cookies[:service] = temp
    end
    @img = @@img_src[cookies[:service]]["img"]
    @tag_line = @@img_src[cookies[:service]]["tagline"]
  end

  def set_city
    cookies[:city] = params[:cities]
    redirect_to :index
  end

  private

  def order_params
    params.permit(:customer_id, :service, :booking_date, :booking_slot, :customer_comments, :name, :address, :phone, :email)
  end

  #gurgaon_services = Array.new("Electrical", "Plumbing", "Packers and Movers", "Car Wash", "Pest Control", "Computer Repair", "Appliance Repair", "House Cleaning", "Carpenter", "Cook", "Painter", "Keymaker")
  #@@bangalore_services = Array.new("Electrical", "Plumbing", "Packers and Movers", "Car Wash", "Pest Control", "Computer Repair", "Appliance Repair", "House Cleaning", "Carpenter", "Cook", "Painter", "Keymaker")


  def get_services_list
  end

end
