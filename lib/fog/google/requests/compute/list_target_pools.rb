module Fog
  module Compute
    class Google
      class Mock
        def list_target_pools(region_name)
          Fog::Mock.not_implemented
        end
      end

      class Real
        def list_target_pools(region_name)
          api_method = @compute.target_pools.list
          parameters = {
            'project' => @project,
            'region' => region_name
          }

          request(api_method, parameters)
        end
      end
    end
  end
end
