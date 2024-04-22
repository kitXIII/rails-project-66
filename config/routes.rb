# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resource :auth, only: [], controller: :auth do
      delete :logout
    end

    root 'home#index'

    resources :repositories, only: %i[index new]
  end
end
