Rails.application.routes.draw do
  root "home#index"
  devise_for :candidates, path: 'candidates'
  devise_for :employees, path: 'employees'
  resources :companies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
