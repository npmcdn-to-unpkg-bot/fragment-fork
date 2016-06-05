Rails.application.routes.draw do
  # get 'boarding/index'


  resources :boarding do
    post 'seteditingsite'
    get 'search'
    resources :category do
      resources :site
      get 'movecategory'
    end
  end

  resources :category do
    resources :site do
      get 'movesite',via: :post
    end
    get 'movecategory'
  end

  root 'boarding#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
