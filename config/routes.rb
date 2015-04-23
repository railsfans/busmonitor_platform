require 'sidekiq/web'
BusmonitorPlatform::Application.routes.draw do |map|
	mount Sidekiq::Web=>'/sidekiq'
	resource  :session
	match '/login' => "sessions#new", :as => "login" 
	match '/logout' => "sessions#destroy", :as => "logout"
	match 'home/test' => "home#test"
	match 'home/init' => "home#init"
	match 'home/get_personinfo' => "home#get_personinfo"
	match 'home/modify_personinfo'=>"home#modify_personinfo"
	match 'home/city'=>"home#city"
	match 'home/station'=>"home#station"
	match 'home/bus'=>"home#bus"
	match 'home/add_cityinfo'=>"home#add_cityinfo"
	match 'home/edit_cityinfo'=>"home#edit_cityinfo"
	match 'home/delete_cityinfo'=>"home#edit_cityinfo"
	match 'home/backup'=>"home#backup"
	match 'home/deploy'=>"home#deploy"
	match 'home/deployprogress'=>"home#deployprogress"
	match 'home/projectid'=>"home#projectid"
	match 'home/allprojectid'=>"home#allprojectid"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "home#init"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))', :via => :all
	match '*a', :to=>'sessions#routeerror'
end
