Rails.application.routes.draw do
  # Api definition
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :tokens, only: [:create]
      resources :users, only: [:show, :create, :update, :destroy] do
        collection do
          get '/' => 'users#list'
          put '/:id/block' => 'users#block'
          put '/:id/unblock' => 'users#unblock'
        end
      end
    end
  end
end
