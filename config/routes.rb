Rails.application.routes.draw do
  # Api definition
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :update, :destroy] do
        collection do
          get '/' => 'users#list'
        end
      end
    end
  end
end
