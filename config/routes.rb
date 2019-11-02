Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'

  namespace 'api' do
  	namespace 'v1' do
      get '/find', to: 'repositories#search_repo'
      get '/username', to: 'repositories#find_user'
      
      get '/repositories', to: 'repositories#index'
      
  	end
  end
end
