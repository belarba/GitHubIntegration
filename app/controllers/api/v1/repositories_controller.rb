module Api
	module V1
    class RepositoriesController < ApplicationController  
			before_action :authorize_request, except: :create
			# before_action :find_user, except: %i[create index]

			# def getData(response)
			# 	solution = []
			# 	JSON.parse(response).each do |item|
			# 		solution << item[0]
			# 	end    
				
			# 		# repos = getData(response)
			# 		repos.each do |item|
			# 			resposta << 
			# 			:full_name = item['full_name']
			# 			:description = item['description']
			# 			:owner = item['owner']['']
			# 		end
			# end

			def index
				response = RestClient.get "https://api.github.com/repositories?page=2&per_page=100"
				repos = JSON.parse(response)
				render json: repos
			end 

			def find_user
				base_url = 'https://api.github.com/search/users?q='
				response = RestClient.get base_url + params[:username]
				repos = JSON.parse(response)
				render json: repos
			end

			def search_repo
				base_url = 'https://api.github.com/search/repositories'
				query = '?q='
				controle = 0

				if(params[:free_text])
					texto = params[:free_text]
					texto.gsub! ' ', '+'
					query += texto
					controle = 1
				end

				if(params[:username])
					if(controle == 1)
						controle = 0
						query += '+'
					end
					query += 'user:'+params[:username]
					controle = 1
				end

				if(params[:language])
					if(controle == 1)
						controle = 0
						query += '+'
					end
					query += 'language:'+params[:language]
				end
				
				if(params[:sort_by_star] || params[:order_by_fork])
					query += '&sort='
				end

				if(params[:sort_by_star])
				 query += 'stars'
				 controle = 1
				end

				if(params[:sort_by_fork])
					if(controle = 1)
						controle = 0
						query += '+'
					end
					query += 'forks'
				end

				if(params[:order_by])
					query += '&order='+params[:order_by]
				end

				response = RestClient.get base_url + query
				repos = JSON.parse(response)
				# render json: repos['items']
				
				saida_final = []
				saida = {}

				repos['items'].each do |item|
					saida['nome_completo'] = item['full_name']
					saida['descricao'] = item['description']
					saida['qtd_estrela'] = item['stargazers_count']
					saida['qtd_forks'] = item['forks']
					saida['nome_autor'] = item['owner']['login']
						# saida['aaa'] = item['full_name']
					 	saida_final << saida
					 	saida = {}
				end
				
				render json: saida_final

			end

		end
	end
end