Rails.application.routes.draw do
  devise_for :users
  resources :wine_strains
  resources :strains
  resources :wines
  root 'wines#index'
end
