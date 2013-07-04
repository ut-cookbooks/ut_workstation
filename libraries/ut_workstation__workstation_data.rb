module UTWorkstation

  module Helpers

    def workstation_data
      node.run_state["workstation_data"] ||= Hash.new
    end

    def workstation_users
      node.run_state["workstation_users"] ||= Hash.new
    end

    def load_workstation_data!
      workstation_data = begin
        data_bag_item('workstation', node['platform']).to_hash
      rescue => ex
        Hash.new
      end
    end

    def load_workstation_users!
      Array(user_array).each do |username|
        workstation_users[username] = user_data(username)
      end
    end

    private

    # Fetch the user array from the node's attribute hash. If a subhash is
    # desired (ex. node['base']['user_accounts']), then set:
    #
    #     node['user']['user_array_node_attr'] = "base/user_accounts"
    #
    def user_array
      @user_array ||= begin
        user_array = node
        node['user']['user_array_node_attr'].split("/").each do |hash_key|
          user_array = user_array.send(:[], hash_key)
        end
        user_array
      end
    end

    def user_data(username)
      data_bag_item(node['user']['data_bag_name'], username).to_hash
    rescue => ex
      Hash.new
    end
  end
end
