require 'fog/core/collection'
require 'fog/rackspace/models/orchestration/stack'

module Fog
  module Orchestration
    class Rackspace
      class Stacks < Fog::Collection
        model Fog::Orchestration::Rackspace::Stack

        def all
          load(service.list_stacks.body['stacks'])
        end

        def find_by_id(id)
          self.find {|stack| stack.id == id}
        end
        alias_method :get, :find_by_id
      end
    end
  end
end
