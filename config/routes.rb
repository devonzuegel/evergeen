Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root             'static_pages#home'

  get 'support' => 'static_pages#support'
  get 'about'   => 'static_pages#about'
  get 'mission' => 'static_pages#mission'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'deposit' => 'transactions#deposit'
  get 'withdraw' => 'transactions#withdraw'

  ##
  # Arranges for the URLs for following and followers to look like
  # '/users/1/following' and '/users/1/followers' respectively. Both
  # pages will be showing data, so the proper HTTP verb is a GET request.
  ##
  # The 'member' method arranges for the routes to respond to URLs
  # containing the user id. The other possibility, collection, works
  # without the id (ex: '/users/tigers' displays all tigers in our app).
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :charges
  resources :transactions
  
  ##
  # Model account activations as a resource even though they won’t be 
  # associated with an Active Record model. Instead, we’ll include the
  # relevant data (including the activation token and activation status)
  # in the User model. Nevertheless, we’ll interact with account 
  # activations via a standard REST URL.
  resources :account_activations, only: [:edit]

  ##
  # We need forms both for creating new password resets and for updating
  # them by changing the password in the User model.
  resources :password_resets, only: [:new, :create, :edit, :update]

  ##
  # The interface to Micropost & Relationship resources runs through
  # the Profile and Home pages, so we won’t need actions like new or edit
  # in the Microposts controller; we’ll need only create and destroy.   
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  # --------------------------------------------------------------------

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
