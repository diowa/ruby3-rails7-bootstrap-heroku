# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'pages#home'
  get :hello_world, to: 'pages#hello_world'
end
