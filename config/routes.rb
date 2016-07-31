RailsStarter::Application.routes.draw do
  resources :child_drugs


  resources :child_todays


  resources :children


  resources :drug_infos


  resources :users


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  get ':controller(/:action(/:id))'
  root :to => 'say#hello'

  get '/user_form', to: 'forms#user'
  get '/dashboard', to: 'dashboard#index'


  resource :messages do
    collection do
      post 'reply'
    end
  end
end
