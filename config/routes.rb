# frozen_string_literal: true

Rails.application.routes.draw do
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
