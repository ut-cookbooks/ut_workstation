bashrc_installs = workstation_users.select { |user, data|
  !data['bashrc'].nil? && !data['bashrc'] == false
}.map { |user, data|
  { 'user' => user, 'update' => true }.
    merge(data['bashrc'].is_a?(Hash) ? data['bashrc'] : Hash.new)
}

node.set['bashrc']['user_installs'] = bashrc_installs

include_recipe "bashrc::user"
