Rails.application.routes.draw do
  resources :wine_strains
  resources :strains
  resources :wines
  root 'wines#index'
end
