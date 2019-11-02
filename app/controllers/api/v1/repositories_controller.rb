module Api
	module V1
    class RepositoriesController < ApplicationController  
			before_action :authorize_request, except: :create
			before_action :find_user, except: %i[create index]

			def index
				require "json"

				response = RestClient.get "https://api.github.com/users/lewagon/repos"
				repos = JSON.parse(response)
				render json: repos
				# render json: {status: 'SUCCESS', message:'Artigos carregados'},status: :ok
			end 
		end
	end
end