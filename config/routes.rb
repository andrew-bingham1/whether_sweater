Rails.application.routes.draw do
 namespace :api do
  namespace :v0 do
    get 'forecast', to: 'forecast#index'
    post 'users', to: 'users#create'
    post 'sessions', to: 'sessions#create'
    get 'book-search', to: 'booksearch#index'
  end
 end
end
