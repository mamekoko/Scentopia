Rails.application.routes.draw do

  devise_for :admin_users, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users

  namespace :admins do
    resources :users, only: [:index, :show] 
  end

  scope module: 'public' do
    root "homes#top"
    get "search" => "searches#search"

    resources :post_images, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resource :likes, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      member do
        get :likes
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
