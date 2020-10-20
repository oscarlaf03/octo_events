class WebhookInterpreter

    def initialize(body)
        @body = body
    end

    def standard_event?
        @body.keys.include? 'action' 
    end

    def push_event?
        standard = standard_event?
        keys = @body.keys
        has_ref = keys.include? 'ref'
        has_before = keys.include? 'before'
        has_after = keys.include? 'after'
        !standard && has_ref && has_before && has_after
    end

    def should_interpret?
        standard_event? || push_event?
    end





end
