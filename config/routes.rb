Rails.application.routes.draw do
  resources :weathers
  resources :weatherlogs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'weathers#index' 
  get 'Run Scraper' => 'weathers#loop_one', as: :loop
 
end

