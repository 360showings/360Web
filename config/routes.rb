Municipal::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  resources :candidates, :only => [] do
    post 'interested', :on => :collection
  end
  
  root :to => 'static_pages#home'
  
  match '/about', :to => 'static_pages#about'
  match '/contact', :to => 'static_pages#contact'
  match "/legal" => "static_pages#legal"
  match "/privacy" => "static_pages#privacy"
  match "/comment" => "static_pages#comment", :via => :post
end
