Rails.application.routes.draw do

  namespace :api, default: {format: :json} do
    namespace :v1 do

      resources :buyers, shallow: true do

      end

      resources :sellers, shallow: true do

      end
      
      resources :admins, shallow: true do
      end
    
    end
  end
end
