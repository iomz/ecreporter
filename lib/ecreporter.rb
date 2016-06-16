%w(
  awesome_print
  faye/websocket
  haml
  json
  naturally
  nokogiri
  open-uri
  puma
  rubygems
  sinatra/activerecord
  sinatra/base
  tilt/haml
  time
  yaml
).each { |lib| require lib }

include ActiveModel::Serializers::Xml

%w(
  nokogiri_ext
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
      content_type :xml
      parsed_hash = Hash.from_xml(params["xml"])
      # ap parsed_hash
      begin
        group = parsed_hash["ECReports"]["reports"]["report"]["group"]
        count = Integer(group["groupCount"]["count"])
        epcs = []
        member = parsed_hash["ECReports"]["reports"]["report"]["group"]["groupList"]["member"]
        if count < 2
          epcs << member["epc"]
        else
          member.each do |m|
            epcs << m["epc"]
          end
        end
        tags = Naturally.sort(epcs)
        ap tags
        WebsocketHandler.broadcast({ tags: tags})
        #ap Nokogiri::XML(params["xml"]).children
        #WebsocketHandler.broadcast({ xml: request.body})
        #WebsocketHandler.broadcast(Hash.from_xml(request.body.read).to_json)
      rescue NoMethodError => e
        p "## groupList empty!"
      end
      nil
    end
  end
end

