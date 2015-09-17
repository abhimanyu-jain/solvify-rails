Rails.application.routes.draw do
  #devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'generic_orders#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'service_page_selection' => 'generic_orders#select_service_page'
  get 'Personal_Info' => 'generic_orders#personal'

  get 'service'  => 'generic_orders#orderInfo'
  get 'Plumbing' => 'generic_orders#orderInfoForm'
  get 'Electrical' => 'generic_orders#orderInfoForm'
  get 'Appliance Repair' => 'generic_orders#orderInfoForm', as: :Appliance
  get 'Car Wash' => 'generic_orders#orderInfoForm', as: :Car
  get 'Carpenter' => 'generic_orders#orderInfoForm'
  get 'Computer Repair' => 'generic_orders#orderInfoForm', as: :Computer
  get 'Cook' => 'generic_orders#orderInfoForm'
  get 'House Cleaning' => 'generic_orders#orderInfoForm', as: :Cleaning
  get 'Keymaker' => 'generic_orders#orderInfoForm'
  get 'Laundry' => 'generic_orders#orderInfoForm'
  get 'Packers And Movers' => 'generic_orders#orderInfoForm', as: :PAM
  get 'Painter' => 'generic_orders#orderInfoForm'
  get 'Pest Control' => 'generic_orders#orderInfoForm', as: :Pest
  post 'confirmation' => 'generic_orders#orderConfirmation'
  get 'dashboard' => 'admin#show_all'
  get 'set_city' => 'generic_orders#set_city'
  get 'MyOrders' => 'generic_orders#displayUserOrders', as: :myOrders

  post 'changeStatus' => 'admin#changeStatus'

  devise_for :users, controllers: {registrations: "users/registrations"}

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :generic_orders

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
