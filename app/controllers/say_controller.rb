require 'json'

# Controller and action definition for uri say/hello
# See routing configuration in config/routes.rb
class SayController < ApplicationController
  def hello
    # get user ip from request
    @yourip = request.remote_ip
    
    # use params[:name] to get request parameter value by name
    # @parameter = params[:name]
    
    # get Ruby version and Rails version
    @ruby_version = RUBY_VERSION
    @rails_version = Rails::VERSION::STRING
    
    env = {}
    # loop to parse all JSON object
    # @env is available in the view: views/say/hello.html.erb
    ENV.each do |key, value|
        begin
            obj = JSON.parse(value)
            env[key] = JSON.pretty_generate(obj)
        rescue
            env[key] = value
        end
      end
    @env = env
  end
end