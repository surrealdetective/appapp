Appapp::Application.routes.draw do
  
  resources :courses, :only => [:new, :create, :index]
  get "/courses/dashboard" => "courses#dashboard", :as => "courses_dashboard"

  get "/class" => "class#index"
  post "/class/:dossier_id/decision" => "class#decision", :as=> "class_decision"

  get "/thinner" => "thinner#index"
  get "/testing" => "thinner#testing"
  post "/thinner/:dossier_id/decision" => "thinner#decision", :as=>"thinner_decision"

  get "/dashboard" => "dossiers#index"

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  get '/logout' => "sessions#destroy"

  
  # resources :dossiers, :only => [:new, :create, :show]
  
  # root :to => 'dossiers#new'
  root :to => 'welcome#home'
  

  resources :dossiers, :only => [:new, :create, :show, :index] do
    resources :dossier_statuses, :only => [:new, :create]
    resources :dossier_comments, :only => [:create, :edit, :update, :destroy]
  end

  put '/dossiers/:id/transition/:transition' => 'dossiers#transition', :as => :transition

  # get '/admin' => 'dossiers#index'
  get '/dossiers/filter_by/:filter' => 'dossiers#filter_by', as: :dossiers_filter_by

  get '/dossiers/filter' => 'dossiers#filter', as: :dossiers_filter


  get '/needs_review' => 'needs_review#redirect_to_first', :as => :needs_review_first
  get '/needs_review/:id' => 'needs_review#show', :as => :needs_review_show

  # get '/dossiers/:id/needs-review' => 'needs_review#index', as: :dossier_review
  get '/needs_interview' => 'needs_interview#index', as: :dossier_interview



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
  # match ':controller(/:action(/:id))(.:format)'
end
