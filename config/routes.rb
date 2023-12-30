Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


  match '/404', to: 'api/v1/errors/errors#not_found', via: :all
  match '/422', to: 'api/v1/errors/errors#unacceptable', via: :all
  match '/500', to: 'api/v1/errors/errors#internal_error', via: :all


  namespace 'api' do
    namespace 'v1' do
      namespace 'status' do
        get '/', to: 'health#index'
      end

      namespace 'payment' do
        post '/', to: 'payment#create'
        post '/random', to: 'payment#random'
        post '/deny', to: 'payment#denied'
        post '/approve', to: 'payment#approved'
        post '/deny/:reason', to: 'payment#deny_condition'
        post '/pay', to: 'payment#simulate'
      end
    end
  end

end
