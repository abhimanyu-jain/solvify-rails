class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

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


  helper_method :img_src
  def img_src
    if cookies[:city] == "Bangalore"
      return @@img_src
    else
      @ggn_list = @@img_src
      @ggn_list.delete("Cook")
      @ggn_list.delete("Painter")
      @ggn_list.delete("Keymaker")
      return @ggn_list
    end

    return @@img_src
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
