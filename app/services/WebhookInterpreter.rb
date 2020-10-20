class WebhookInterpreter
    require 'json'
    require 'net/http'
    attr_reader :event_type, :body, :headers,
    :readable, :event_type, :event_type_key

    def initialize(request)
        @event_type_key = 'X-GitHub-Event'
        @request = request
        @body = JSON.parse(@request.body.read)
        @headers = request.headers
        @readable = request.headers.key? @event_type_key
        @event_type = request.headers[@event_type_key]
    end

    def standard_event?
        @event_type != 'push' && @readable
    end

    def push_event?
        @readable && @event_type == 'push'
    end

    def should_interpret?
        standard_event? || push_event?
    end





end
