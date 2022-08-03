Rails.application.routes.draw do
  root "application#index"
  post "/check", to: "application#check"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
