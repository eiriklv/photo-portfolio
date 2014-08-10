PhotoPortfolio::Application.routes.draw do
  devise_for :users
  resources :albums, path: 'admin/albums' do
    collection do
      post :sort
    end
  end
  resources :photos, path: 'admin/photos' do
    collection do
      post :sort
    end
    member do
      get :publish_on_facebook
      get :refresh_from_facebook
    end
  end
  resources :lenses, path: 'admin/lenses'
  resources :lens, path: 'admin/lenses'
  resources :cams, path: 'admin/cams'
  get 'admin' => 'photos#index'

  get 'api/cams' => 'api#cams'
  get 'api/lenses' => 'api#lenses'
  get 'api/photos' => 'api#photos'
  get 'api/albums' => 'api#albums'

  get 'photo' => 'application#frontend'
  get 'photo/:album_id' => 'application#frontend'
  get 'photo/:album_id/:photo_id' => 'application#frontend'
  get 'about' => 'application#frontend'
  get 'contact' => 'application#frontend'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#frontend'

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
