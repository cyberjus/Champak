Champax::Application.routes.draw do

  namespace :admin do
    root :to => 'coupons#index'
    resources :businesses
    resources :categories 
    resources :coupons
    resources :settings, :only => [:index]
    match '/settings/set_ads', :to => 'settings#set_ads', :as => :settings_set_ads
    resources :ads
    resources :sessions, :only => [:new, :create, :destroy]
    resources :admin_user, :only => [:edit, :update]
    
    match '/login', :to => 'sessions#new'
    match '/logout', :to => 'sessions#destroy'
  end
  
  match "/c/:id/" => 'views#tweet_link'
  match "/New-Coupons" => 'views#by_new', :as => :coupons_by_new 
  match "/Hot-Coupons" => 'views#by_hot', :as => :coupons_by_hot 
  match "/Online-Only-Coupons" => 'views#by_online_only', :as => :coupons_by_online_only
  match "/Search-Coupons" => 'views#search'
  match "/print/:id" => 'views#print_coupon'
  match "/ajax/rate_coupon/:id", :to => "views#rate_coupon", :as => :rate_coupon
  match "/:name/c" => 'views#by_category'
  match "/:name/t" => 'views#by_town'
  match "/:name/d" => 'views#by_distance'
  match "/:business_name/:short_description/:id" => 'views#coupon'
  
  
  root :to => 'pages#home'

end
