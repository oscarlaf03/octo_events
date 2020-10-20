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
        print_data(interpreter.readable)
        interpreter.call

        if body
            head :ok
            "message received succesfully"
        else
            head 400
        end
    end

    private 


    def print_data(data)
        puts "\n\n\n*********PRINTING********\n\n\n"
        puts data
        puts "\n\n\n*********END PRINT********\n\n\n"
    end

end
