class WebhooksController < ApplicationController
    require 'json'
    require 'net/http'
    #   skip_before_action :verify_authenticity_token, only:[:receive]
    #   skip_before_action :authenticate_user!, only:[:receive]

    def receive
        raw =  request.body.read
        body = JSON.parse(raw)
        if body
            puts "\n\n\n*********PRINTING********\n\n\n"
            puts treat_body(body)
            puts "\n\n\n*********END PRINT********\n\n\n"

            head :ok
            "message received succesfully"
        else
            head 400    
        end
    end

    private 
    def treat_body(body)
        {
            action: body["action"] || "no action",
            sender: body["sender"] || "no sender",
            repository: body["repository"] || "no repository",
            organization: body['organization'] || "no organization",
            installation: body["installation"] || "no installation"
        }

    end

end
