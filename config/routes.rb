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
   resources :fieldss, only: [:index, :show, :update, :destroy, :new ]

 end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: "home#top"
end
