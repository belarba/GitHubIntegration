module Api
	module V1
    class RepositoriesController < ApplicationController  
			before_action :authorize_request, except: :create
			before_action :find_user, except: %i[create index]

			def index
				response = RestClient.get "https://api.github.com/repositories"
				repos = JSON.parse(response)
				render json: repos
			end 
		end
	end
end