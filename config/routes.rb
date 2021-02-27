Rails.application.routes.draw do
  root "home#index"
  devise_for :candidates, path: 'candidates'
  devise_for :employees, path: 'employees', controllers: { registrations: "registrations" }
  resource :search
  resource :candidate
  resources :offers do
    member do
      post 'make' 
      get 'decline'
      get 'proposal'
      post 'declined'
      post 'sended'
      get 'refuse'
      get 'accept'
      post 'refused'
      post 'accepted'
    end
  end
  resources :jobcandidates
  resources :companies
  resources :jobs do
    post 'disable', on: :member    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
