# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :tournaments do
    get 'final_results/update'
  end
  namespace :tournaments do
    get 'semifinal_results/update'
  end
  namespace :tournaments do
    get 'quarterfinal_results/update'
  end
  get 'teams/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tournaments#index'
  resources :tournaments, only: [:index, :create, :show]
  namespace :tournaments do
    resources :season_results, only: [:update]
    resources :quarterfinal_results, only: [:update]
    resources :semifinal_results, only: [:update]
    resources :final_results, only: [:update]
  end
  resources :teams, only: [:new, :create]
end
