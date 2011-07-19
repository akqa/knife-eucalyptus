#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Copyright:: Copyright (c) 2011 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/knife/euca_base'

class Chef
  class Knife
    class EucaServerList < EucaBase

      deps do
        EucaBase.load_deps
      end

      banner "knife euca server list (options)"

      def run
        $stdout.sync = true

        server_list = [
          ui.color('Instance ID', :bold),
          ui.color('Public DNS Name', :bold),
          ui.color('Flavor', :bold),
          ui.color('Image', :bold),
          ui.color('Security Groups', :bold),
          ui.color('State', :bold)
        ]

        connection.servers.all.each do |server|
          server_list << server.id.to_s
          server_list << (server.dns_name || "" )
          server_list << (server.flavor_id || "")
          server_list << (server.image_id || "")
          server_list << server.groups.join(", ")
          server_list << server.state
        end
        puts ui.list(server_list, :columns_across, 6)
      end
    end
  end
end


