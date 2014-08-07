#
# Cookbook Name:: ut_workstation
# Libraries:: helpers
#
# Copyright 2013, Fletcher Nichol
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

module UTWorkstation

  module Helpers

    def workstation_data
      node.run_state["workstation_data"]
    end

    def workstation_users
      node.run_state["workstation_users"]
    end

    def load_workstation_data!
      node.run_state["workstation_data"] = begin
        data_bag_item("workstation", node["platform"]).to_hash
      rescue
        Hash.new
      end
    end

    def load_workstation_users!
      node.run_state["workstation_users"] = Hash.new
      Array(user_array).each do |username|
        workstation_users[username] = user_data(username)
      end
    end

    private

    # Fetch the user array from the node's attribute hash. If a subhash is
    # desired (ex. node["base"]["user_accounts"]), then set:
    #
    #     node["user"]["user_array_node_attr"] = "base/user_accounts"
    #
    def user_array
      @user_array ||= begin
        user_array = node
        node["user"]["user_array_node_attr"].split("/").each do |hash_key|
          user_array = user_array.send(:[], hash_key)
        end
        user_array
      end
    end

    def user_data(username)
      data_bag_item(node["user"]["data_bag_name"], username).to_hash
    rescue
      Hash.new
    end
  end
end
