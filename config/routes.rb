Rails.application.routes.draw do

  #resources :cuisines

  resources :hotels, :except=>['show','create' ]
get 'hotels/edit' do
  get 'hotels/edit'
end
  get 'hotels/hotelEdit'
  get 'cuisines/new'
  patch 'cuisines/create'
  patch 'cuisines/update'
  get 'hotel_users/signup'
  get 'hotels/createUserForHotel'
  get 'hotels/createnewhotel'
  get 'hotels/createHotel'
 get 'hotels/createUserForHotel'
  get 'hotels/createnewhotel'
  get 'hotels/createHotel'
  get 'offers/index'

  get 'offers/show'

  get 'offers/create'

  get 'offers/new'

  get 'offers/destroy'

  get 'offers/edit'

  root 'homepage#index'
  #resources :menus
  get 'line_items/create'
  get 'line_items/ddd'
  get 'line_items/destroy'
  #resources :categories
  #resources :line_items
  get 'carts/destroy'
  # resources :carts
  #resources :orders
  #resources :hotels
  #resources :admin
  get 'orders/placeOrder'
  #get 'orders/placeOrder2'
  get 'orders/new'
  get 'orders/show'
get 'orders/delivery'
  #root 'users#login'

  get 'menus/index'
  get 'menus/edit'
  get 'menus/new'
   patch 'menus/updateMenu'
  #get 'hotels/show'
  get 'categories/index'
  get 'categories/show'
 
  get 'homepage/login'
get 'orders/userDashboard'
get 'orders/editDashboard'
get 'hotel_users/editHotelUser'
  #get 'access/login', :to=> "categories#login"
  # post '/menus', :to=> 'menus#index', as: 'patient',:render=>'menus#index'
  match ':controller(/:action(/:id))(.:option)',:via=>[:get,:post]

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
# root 'welcome#index'

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
