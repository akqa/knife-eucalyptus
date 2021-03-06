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
    class EucaImageList < EucaBase

      deps do
        EucaBase.load_deps
      end

      banner "knife euca image list (options)"

      def run
        image_list = [
          ui.color('ID', :bold),
          ui.color('Kernel ID', :bold),
          ui.color('Architecture', :bold),
          ui.color('Location', :bold)
        ]

        connection.images.sort_by do |image|
          [image.location, image.architecture].compact
        end.each do |image|
          image_list << image.id
          image_list << image.kernel_id
          image_list << image.architecture
          image_list << image.location
        end

        image_list = image_list.map do |item|
          item.to_s
        end

        puts ui.list(image_list, :columns_across, 4)
      end
    end
  end
end
