Champax::Application.routes.draw do

  namespace :admin do
    root :to => 'coupons#index'
    resources :businesses
    resources :categories 
    resources :coupons
    resources :sessions, :only => [:new, :create, :destroy]
    resources :admin_user, :only => [:edit, :update]
    
    match '/login', :to => 'sessions#new'
    match '/logout', :to => 'sessions#destroy'
  end
  
  match "/:name/c/" => 'views#by_category'
  match "/:name/t/" => 'views#by_town'
  match "/:business_name/:short_description/:id/" => 'views#coupon'
  match "/print/:id" => 'views#print_coupon'
  
  root :to => 'pages#home'

end
