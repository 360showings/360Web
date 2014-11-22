Municipal::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  root :to => 'static_pages#home'
  
  match '/about', :to => 'static_pages#about'
  match '/contact', :to => 'static_pages#contact'
  match "/legal" => "static_pages#legal"
  match "/privacy" => "static_pages#privacy"
end
