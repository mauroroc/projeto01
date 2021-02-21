Rails.application.routes.draw do
  root "home#index"
  devise_for :candidates, path: 'candidates'
  devise_for :employees, path: 'employees'
  resource :search
  resources :companies
  resources :jobs do
    post 'disable', on: :member    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
