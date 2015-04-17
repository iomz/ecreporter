%w(
  faye/websocket
  haml
  json
  open-uri
  puma
  sinatra/activerecord
  sinatra/base
  time
  yaml
).each { |lib| require lib }

%w(
  core
  websocket_handler
).each { |name| require_dependency File.expand_path("../ecreporter/#{name}", __FILE__) }

module ECReporter
  class App < Sinatra::Base
    set :root, File.expand_path("../../", __FILE__)

    get '/' do
      haml :index
    end

    post '/notify' do
      p request.body.read
    end
  end
end

