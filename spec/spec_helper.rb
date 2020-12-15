require 'rspec'
require 'rack/test'
require 'faker'
require 'pg_search'
require_relative '../app.rb'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
Dir['./spec/services/**/*.rb'].sort.each { |f| require f }

set :environment, :test

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
  ActiveRecord::Base.logger = nil
  ENV['LOG'] == true
end
