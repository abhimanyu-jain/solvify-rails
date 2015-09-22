class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  @@img_src = Hash.new
  @@img_src = {
      "Packers And Movers" => {
          "img" => "packer_img.png",
          "tagline" => "We help you move, 24x7, 365 days a year. Contact us to get rid of all your moving worries."
      },
      "Electrical" => {
          "img" => "electrical.png",
          "tagline" => "Whether it's a fan that doesn't work or a geyser that fails you in winter, contact us to Solvify all your electrical problems."
      },
      "Plumbing" => {
          "img" => "plumbing2.jpg",
          "tagline" => "Leakages, tap and faucet repairs, blockages, we fix them all. Contact us for all your plumbing needs."
      },
      "Car Wash" => {
          "img" => "car_wash2.gif",
          "tagline" => "Have your car looking as good as new. "
      },
      "Laundry" => {
          "img" => "laundry.png",
          "tagline" => "No matter how bad the stains, we will take care of them."
      },
      "Computer Repair" => {
          "img" => "computer.jpg",
          "tagline" => "Viruses causing mayhem? Hard disk not working properly? Leave your worries to our awesome technicians!!!"
      },
      "Appliance Repair" => {
          "img" => "appliance.jpg",
          "tagline" => "AC not working in the summer heat? Geyser not working in the shivering winters? Don't worry, just call us and we will take care of it!!!"
      },
      "Pest Control" => {
          "img" => "pest.gif",
          "tagline" => "We perfectly understand how pests can make life truly miserable. Whether you are a business institution, home, hospital or any other place, we offer you timely and expert help."
      },
      "House Cleaning" => {
          "img" => "cleaning.jpg",
          "tagline" => "A clean home is a happy home."
      },
      "Keymaker" => {
          "img" => "keymaker.jpg",
          "tagline" => "Locked out of your home? Lost your keys? Solvify to the rescue!!"
      },
      "Carpenter" => {
          "img" => "carpenter.jpg",
          "tagline" => "Find a carpenter to build beautiful furniture for your dream home."
      },
      "Cook" => {
          "img" => "cook.jpg",
          "tagline" => "Find a cook who cooks as per your taste and requirements."
      },
      "Painter" => {
          "img" => "painting.jpg",
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
