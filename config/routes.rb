HeliCat::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#show'

  get  "inventory/location"               => "inventory#index",              defaults: {by: "location"}
  get  "inventory/department"             => "inventory#index",              defaults: {by: "department"}
  get  "inventory/make"                   => "inventory#index",              defaults: {by: "make"}
  get  "inventory/model"                  => "inventory#index",              defaults: {by: "model"}
  get  "user/:user"                       => "items#find",                   as: "find_user"
  get  "serial/:serial"                   => "items#find",                   as: "find_serial"
  get  "barcode/:barcode"                 => "items#find",                   as: "find_barcode"
  get  "department/:department"           => "items#find",                   as: "find_department"
  get  "location/:location"               => "items#find",                   as: "find_location"
  get  "not_received"                     => "items#find",                   as: "not_received",  defaults: {received: false}
  get  "not_purchased"                    => "items#find",                   as: "not_purchased", defaults: {purchased:  false}
  get  "to_be_swapped"                    => "items#to_be_swapped",          as: "to_be_swapped"
  get  "items/:id/choose_swap"            => "items#choose_swap",            as: "choose_swap_item"
  post "items/:id/change_swap_model"      => "items#change_swap_model",      as: "change_swap_model_item"
  post "items/:id/request_swap_purchase"  => "items#request_swap_purchase",  as: "request_swap_purchase"
  get  "items/:id/swap"                   => "items#swap",                   as: "swap_item"
  post "items/:id/do_swap"                => "items#do_swap",                as: "do_swap_item"
  get  "purchase_option/:id/deactivate"   => "purchase_options#deactivate",  as: "deactivate_purchase_option"
  get  "purchase_option/:id/activate"     => "purchase_options#activate",    as: "activate_purchase_option"

  resources :inventory
  resources :items
  resources :purchase_options
  resources :purchase_process
  resources :purchases

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
