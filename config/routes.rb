Rails.application.routes.draw do
    devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
    devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

    namespace :admin do
      get '/' => 'homes#top'
      resources :customers,   only: %i(index show edit update create destroy)
      resources :diarys,      only: %i(index destroy)
    end

    scope module: :public do
        root :to                             =>  'homes#top'
        get    '/about'                      =>  'homes#about'
        get    'customers/withdraw_confirm'  =>  'customers#withdraw_confirm'
        patch  'customers/withdraw'          =>  'customers#withdraw'
        get    'customers/information/edit',             to: 'customers#edit', as: 'edit_customer'
        patch  'customers/information',      to: 'customers#update', as: 'update_customer'
      resources :diarys do
        resources :comments, only: %i(create destroy)
        resource :favorites, only: %i(create destroy)
      end

      resources :customers,  only: %i(show edit update index ) do
        member do
        get 'favorites' , to: 'customers#favorite'
        end
        resource :relationships, only: %i(create destroy)
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end

      get    'searchs/search'             =>  'searchs#search'
      post '/guests/guest_sign_in', to: 'guests#new_guest'
      resources :sentiments,      only: %i(create destroy)

      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
end
