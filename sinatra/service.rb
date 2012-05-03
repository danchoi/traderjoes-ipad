require 'sinatra'
require 'yaml'
require 'json'



class TjService < Sinatra::Base
  before do
    content_type :json
  end
  get '/products' do
    data = YAML::load_file("products.yml")
    {categories: data}.to_json
  end
  get '/recipes' do
    data = YAML::load_file("recipes.yml")
    {categories: data}.to_json
  end
end
