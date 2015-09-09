Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'generic_orders#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'service_page_selection' => 'generic_orders#select_service_page'
  get 'Personal_Info' => 'generic_orders#personal'

  get 'Plumbing' => 'generic_orders#plumbing'
  get 'Electrical' => 'generic_orders#electrical'
  get 'Appliance Repair' => 'generic_orders#appliance_repair'
  get 'Car Wash' => 'generic_orders#car_wash'
  get 'Carpenter' => 'generic_orders#carpenter'
  get 'Computer Repair' => 'generic_orders#computer_repair'
  get 'Cook' => 'generic_orders#cook'
  get 'House Cleaning' => 'generic_orders#house_cleaning'
  get 'Keymaker' => 'generic_orders#keymaker'
  get 'Laundry' => 'generic_orders#laundry'
  get 'Packers And Movers' => 'generic_orders#movers_packers'
  get 'Painter' => 'generic_orders#painter'
  get 'Pest Control' => 'generic_orders#pest_control'

  get 'dashboard' => 'admin#show_all'
  get 'set_city' => 'generic_orders#set_city'
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
