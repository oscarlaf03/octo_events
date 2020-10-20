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

    def call
        save_event
    end

    def standard_event?
        @event_type != 'push' && @readable
    end

    def push_event?
        @readable && @event_type == 'push'
    end

    def sender_github_id
        @readable ? @body['sender']['id'] : nil
    end

    def repository_github_id
        @readable ? @body['repository']['id'] : nil
    end

    def save_event
        if @readable
            @sender = Sender.find_by github_id: sender_github_id || Sender.new(github_id: sender_github_id, username: @body['sender']['login'])
            @repository = Repository.find_by github_id: repository_github_id || Repository.new(github_id: repository_github_id,name:@body['repository']['name'], url:@body['repository']['url'])
            @sender.save
            @repository.save
            if standard_event?
                @event = Event.new(event_type:@event_type, action:@body['action'])
            else push_event?
                @event = Event.new(event_type:@event_type, action:@event_type)
            end
            @event.repository = @repository
            @event.sender = @sender
            @event.save

        end
    end
end
