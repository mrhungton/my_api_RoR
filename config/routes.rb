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
      resources :blogs, only: [:show, :create, :update, :destroy] do
        collection do
          get '/' => 'blogs#list'
          put '/:id/publish' => 'blogs#publish'
          put '/:id/unpublish' => 'blogs#unpublish'
          put '/:id/like' => 'blogs#like'
          put '/:id/unlike' => 'blogs#unlike'
          get '/featured_list' => 'blogs#featured_list'
          get '/:url-:id' => 'blogs#show'
        end
      end
    end
  end
end
