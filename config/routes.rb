Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tasks do
    member do
      patch :toggle_complete
    end
  end
end
