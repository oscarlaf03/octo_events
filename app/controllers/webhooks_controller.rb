class WebhooksController < ApplicationController
    require 'json'
    require 'net/http'
    #   skip_before_action :verify_authenticity_token, only:[:receive]
    #   skip_before_action :authenticate_user!, only:[:receive]

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
