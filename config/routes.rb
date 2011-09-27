JobOps::Application.routes.draw do

  resources :industry, :only => [:index, :show]

  get "job_searches_user/new/", :controller => :job_searches_user, :action => :new, :defaults => { :format => 'json' }
  get "job_searches_user/:id", :controller => :job_searches_user, :action => :destroy, :defaults => {:format => 'json'}

  match 'jobs/dashboard' => 'jobs#dashboard', :as => :jobs_dashboard

  resources :jobs, :only => [:index, :show]
  get "/jobs/flag/:id", :controller => :jobs, :action => :flag, :defaults => { :format => 'json' }, :as => :flag_job

  resources :careers, :only => [:index, :show]
  get "/careers/flag/:id", :controller => :careers, :action => :flag, :defaults => { :format => 'json' }, :as => :flag_career

  resources :authentications

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#auth_failure'
  match '/auth/facebook/setup', :to => 'facebook#setup'

  get "settings/index"

  resources :resume, :only => [:index, :edit, :update]

  get "account/index"

  resources :awards

  resources :wars

  resources :languages

  resources :trainings

  resources :certifications

  resources :skills

  resources :educations

  resources :job_histories

  root :to => "home#index"

  devise_for :admins

  devise_for :users, :controllers => { :registrations => 'registrations' }

  resources :users

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
