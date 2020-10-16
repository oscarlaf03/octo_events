class WebhooksController < ApplicationController
    require 'json'
    require 'net/http'

    def receive
    body = JSON.parse(request.body.read)
        if body
            puts body
            head :ok
            "message received succesfully"
        else
            head 400    
        end
    end
end
