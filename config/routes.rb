Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/new'
  get 'groups/create'
  get 'groups/edit'
  get 'groups/update'
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    get "search_tag"=>"books#search_tag"
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
    get 'followings'=>'relationships#followings', as: 'followings'
    get 'followers'=>'relationships#followers', as: 'followers'
    get "daily_posts" => "users#daily_posts"
  end

  resources :messages, only: [:create,:show]

  get 'search'=>'searches#search'

  resources :groups, only: [:new, :create, :index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end