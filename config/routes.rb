Rails.application.routes.draw do
  root "home#index"
  devise_for :candidates, path: 'candidates'
  devise_for :employees, path: 'employees', controllers: { registrations: "registrations" }
  resource :search, only: [:show]
  resource :candidate, only: [:show] 
  resources :job_candidates, only: [:index, :show, :edit, :update]
  resources :companies, only: [:index, :edit, :update, :show]
  resources :jobs, only:[:index, :show, :new, :create, :edit, :update] do
    post 'disable', on: :member
  end
  resources :proposals, only: [:new, :create, :edit, :update]  

end
