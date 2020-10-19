class WebhooksController < ApplicationController
    require 'json'
    require 'net/http'
    #   skip_before_action :verify_authenticity_token, only:[:receive]
    #   skip_before_action :authenticate_user!, only:[:receive]

    def receive
        raw =  request.body.read
    body = JSON.parse(raw)
        if body
            puts raw
            head :ok
            "message received succesfully"
        else
            head 400    
        end
    end
end
