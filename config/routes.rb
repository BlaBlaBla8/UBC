Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'speaking_room#index', to: 'speaking_room#index'

  get 'user_profile/index', to: 'user_profile#index'
  put 'user_profile/update', to: 'user_profile#update'

end
