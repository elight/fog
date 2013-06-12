module Fog
  module Vcloudng
    module Compute
      class Real

        require 'fog/vcloudng/parsers/compute/get_vapp_template'
        
        # Get details of a vapp template
        #
        # ==== Parameters
        # * vapp_template_id<~Integer> - Id of vapp template to lookup
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:

        # FIXME

        #     * 'CatalogItems'<~Array>
        #       * 'href'<~String> - linke to item
        #       * 'name'<~String> - name of item
        #       * 'type'<~String> - type of item
        #     * 'description'<~String> - Description of catalog
        #     * 'name'<~String> - Name of catalog
        #
        # ==== How to get the catalog_uuid?
        #
        # org_uuid = vcloud.get_organizations.data[:body]["OrgList"].first["href"].split('/').last # get the first one
        # org = vcloud.get_organization(org_uuid)
        #
        # catalog_uuid = org.data[:body]["Links"].detect {|l| l["type"] =~ /vcloud.catalog/ }["href"].split('/').last
        # catalog = vcloud.get_catalog(catalog_uuid)
        # catalog_item_uuid = catalog.body["CatalogItems"].first["href"].split('/').last # get the first one
        # catalog_item = vcloud.get_catalog_item(catalog_item_uuid)
        # vapp_template_uuid = catalog_item.body["Entity"]["href"].split('/').last
        # vcloud.get_vapp_template(vapp_template_uuid)
        #
        def get_vapp_template(vapp_template_uuid)
          request(
            :expects  => 200,
            :headers  => { 'Accept' => 'application/*+xml;version=1.5' },
            :method   => 'GET',
            :parser   => Fog::Parsers::Vcloudng::Compute::GetVappTemplate.new,
            :path     => "vAppTemplate/#{vapp_template_uuid}"
          )
        end

      end
    end
  end
end
