Rails.application.routes.draw do
 namespace :api do
  namespace :v0 do
    get 'forecast', to: 'forecast#index'
  end
 end
end
