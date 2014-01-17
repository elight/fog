module Fog
  module Orchestration
    class Rackspace < Fog::Service
      requires :rackspace_username
      requires :rackspace_api_key

      recognizes :rackspace_auth_url
      recognizes :rackspace_region
      recognizes :rackspace_endpoint
      recognizes :persistent

      model_path 'fog/rackspace/models/orchestration'
      model      :stack
      collection :stacks

      request_path 'fog/rackspace/requests/orchestration'
      request :create_stack
      request :update_stack
      request :delete_stack
      request :list_stacks

      class Mock < Fog::Rackspace::Service
      end

      class Real < Fog::Rackspace::Service
        DFW_ENDPOINT = "https://dfw.orchestration.api.rackspacecloud.com/v1"
        ORD_ENDPOINT = "https://ord.orchestration.api.rackspacecloud.com/v1"
        LON_ENDPOINT = "https://lon.orchestration.api.rackspacecloud.com/v1"

        def initialize(options = {})
          rackspace_api_key  = options[:rackspace_api_key]
          rackspace_username = options[:rackspace_username]
          rackspace_auth_url = options[:rackspace_auth_url]
          connection_options = options.fetch(:connnection_options, Hash.new)
          @rackspace_endpoint, @rackspace_region = setup_custom_endpoint(options)

          authenticate(
            :rackspace_api_key => rackspace_api_key,
            :rackspace_username => rackspace_username,
            :rackspace_auth_url => rackspace_auth_url,
            :connection_options => connection_options
          )  
          
          persistent = options.fetch(:persistent, false)
          
          @connection = Fog::Connection.new(endpoint_uri.to_s, persistent, connection_options)
        end

        def service_name
          :cloudOrchestration
        end

        def region
          @rackspace_region
        end

        private

        def setup_custom_endpoint(options)
          endpoint_url = options[:rackspace_orchestration_url] || options[:rackspace_endpoint]
          endpoint     = Fog::Rackspace.normalize_url(endpoint_url)
          region       = nil

          if v2_authentication?
            case endpoint
            when DFW_ENDPOINT
              endpoint = nil
              region = :dfw
            when ORD_ENDPOINT
              endpoint = nil
              region = :ord
            when LON_ENDPOINT
              endpoint = nil
              region = :lon
            else
              # we are actually using a custom endpoint
              region = options[:rackspace_region]
              if region.nil?
                fail "You must specify a rackspace_endpoint, rackspace_orchestration_url, or rackspace_region"
              end
            end
          else
            fail "You must specify a rackspace_endpoint or rackspace_orchestration_url"
          end
          [endpoint, region]
        end
      end
    end
  end
end
      
