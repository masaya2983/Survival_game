Rails.application.routes.draw do
  devise_for :admins,skip: [:registrations, :passwords], path: :admin, controllers:{
   sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers:{
   registrations: "public/registrations",
    sessions: 'public/sessions'
  }

   namespace :admin do
   root :to => "homes#top"
   resources :customers, only: [:index, :show, :update, :destroy]
   resources :fields, only: [:index, :show, :update, :destroy, :new ]

 end
 scope module: :public do
  root to: "home#top"
    resources :customers, only: [:index, :show, :update, :destroy]do
    patch "withdrawal" => "customers#withdrawal", as: 'withdrawl'
    
  end
   resources :fields, only: [:index, :show, :update, :destroy, :new ]do
   resource :favorites, only:[:create,:destroy]
    

  end

  resources :comments, only: [:create,:destroy]



  get "category" => "categories#search"

 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



end
