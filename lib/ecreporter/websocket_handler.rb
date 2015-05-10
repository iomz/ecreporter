module ECReporter
  class WebsocketHandler
    KEEPALIVE_TIME = 15.freeze

    def initialize(app)
      @app = app
      @@clients = []
    end

    def self.broadcast(msg)
      #puts msg[:xml]
      p "### Broadcasting xml"
      @@clients.each do |client|
        client.send(msg.to_json)
      end
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, ping: KEEPALIVE_TIME)

        ws.on(:open) do |event|
          p [:open, ws.object_id]
          @@clients << ws
        end

        ws.on(:message) do |event|
          p [:message, event.data]
          #data = JSON.parse(event.data)
        end

        ws.on(:close) do |event|
          p [:close, ws.object_id, event.code]
          @@clients.delete(ws)
          ws = nil
        end
        ws.rack_response
      else
        @app.call(env)
      end
    end
  end
end
