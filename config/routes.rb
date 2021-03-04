Rails.application.routes.draw do
  root "home#index"
  devise_for :candidates, path: 'candidates'
  devise_for :employees, path: 'employees', controllers: { registrations: "registrations" }
  resource :search, only: [:show]
  resource :candidate, only: [:show]

  #Criar 4 novos controles OfferDecline, OfferProposal, OfferRefuse, OfferAccepted
  resources :offers do
    member do
      post 'make' 
      #get 'decline'
      #get 'proposal'
      #post 'declined'
      #post 'sended'
      get 'refuse'
      get 'accept'
      post 'refused'
      post 'accepted'
    end
  end
  resources :job_candidates, only: [:index, :show, :edit, :update]
  resources :companies, only: [:index, :edit, :update, :show]
  resources :jobs, only:[:index, :show, :new, :create, :edit, :update] do
    post 'disable', on: :member
  end
  resources :proposals, only: [:new, :create, :edit, :update]  

end
