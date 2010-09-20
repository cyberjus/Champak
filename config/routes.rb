Champax::Application.routes.draw do

  namespace :admin do
    resources :businesses
    resources :categories 
    resources :coupons
  end

end
