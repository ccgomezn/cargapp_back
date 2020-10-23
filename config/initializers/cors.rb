Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end

    allow do
        origins '*'
        resource '/api/v1/*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end    

=begin
    allow do
        origins '*'
    
        resource '*',
            methods: [:get, :post, :delete, :put, :patch, :options, :head],
            headers: 'x-domain-token'
    end
    
    allow do
        origins '*'
        resource '/public/*', headers: :any, methods: :get
    
        # Only allow a request for a specific host
        resource '/api/v1/*',
            headers: :any,
            methods: :get,
            if: proc { |env| env['HTTP_HOST'] == 'api.example.com' }
    end
=end


end
