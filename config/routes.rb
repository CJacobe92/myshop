Rails.application.routes.draw do

  namespace :api, default: {format: :json} do
    namespace :v1 do
      
      resources :buyers do
      end

      resources :sellers do
      end

      resources :admins do
      end

    end
  end
end
