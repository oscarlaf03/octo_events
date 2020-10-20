class WebhooksController < ApplicationController
    require 'json'
    require 'net/http'
    # require 'pry'
    #   skip_before_action :verify_authenticity_token, only:[:receive]
    #   skip_before_action :authenticate_user!, only:[:receive]

    def receive
        raw =  request.body.read
        body = JSON.parse(raw)
        interpreter = WebhookInterpreter.new(request)
        interpreter.call
        # event_type = request.headers['X-GitHub-Event']
        # parsed_header = JSON.parse(request.headers)

        if body
            # interpet_body(body)
            # print_data(interpreter.readable)
            head :ok
            "message received succesfully"
        else
            head 400
        end
    end

    private 

    def interpet_body(body)
        interpreter = WebhookInterpreter.new(body)
        puts '**INTERPRETER** is standard_event?  :'
        puts interpreter.standard_event?
        puts '**INTERPRETER** is push_event?  :'
        puts interpreter.push_event?
    end
    def treat_body(body)
        {
            action: body["action"] || "no action",
            sender: body["sender"] || "no sender",
            repository: body["repository"] || "no repository",
            organization: body["organization"] || "no organization",
            installation: body["installation"] || "no installation"
        }

    end

    def print_data(data)
        puts "\n\n\n*********PRINTING********\n\n\n"
        puts data
        puts "\n\n\n*********END PRINT********\n\n\n"
    end

end
