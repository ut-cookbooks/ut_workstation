chruby_installs = workstation_users.select { |user, data|
  !data['chruby'].nil? && !data['chruby'] == false
}.map { |user, data|
  { 'user' => user }.merge(data['chruby'])
}

if !chruby_installs.empty?
  include_recipe "chruby"
  include_recipe "ruby_build"
end

chruby_installs.each do |chruby|
  (chruby['rubies'] || Hash.new).each_pair do |ruby, flag_or_opts|
    user_home       = Etc.getpwnam(chruby['user']).dir
    default_prefix  = ::File.join(user_home, ".rubies", ruby)
    default_group   = Etc.getgrgid(Etc.getpwnam(chruby['user']).gid).name
    opts            = flag_or_opts.is_a?(Hash) ? flag_or_opts : Hash.new

    ruby_build_ruby "Ruby #{ruby} (#{chruby['user']})" do
      definition  ruby
      prefix_path (opts['prefix_path'] || default_prefix)
      user        chruby['user']
      group       (opts['group'] || default_group)

      %w{environment action}.each do |attr|
        send(attr, opts[attr]) if opts[attr]
      end

      not_if { flag_or_opts.nil? || flag_or_opts == false }
    end

    file ::File.join(user_home, ".ruby-version") do
      user    chruby['user']
      group   default_group
      content "#{ruby}\n"

      only_if { opts['default'] == true }
    end
  end
end
