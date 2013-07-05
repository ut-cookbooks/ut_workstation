chruby_installs = workstation_users.select { |user, data|
  !data['chruby'].nil? && !data['chruby'] == false
}.map { |user, data|
  { 'user' => user }.merge(data['chruby'])
}

# until new release of chruby cookbook containing:
# https://github.com/Atalanta/chef-chruby/pull/8
directory "/etc/profile.d" do
  recursive true
end

if !chruby_installs.empty?
  include_recipe "chruby"
  include_recipe "chgems"
  include_recipe "ruby_build"
end

chruby_installs.each do |chruby|
  (chruby['rubies'] || Hash.new).each_pair do |ruby, flag_or_opts|
    opts = flag_or_opts.is_a?(Hash) ? flag_or_opts : Hash.new

    # delay evaluating the ruby_build_ruby resource until after the users are
    # created, this way we can compute a user's home directory and group
    ruby_block "Ruby #{ruby} (#{chruby['user']})" do
      block do
        user_home       = Etc.getpwnam(chruby['user']).dir
        default_prefix  = ::File.join(user_home, ".rubies", ruby)
        default_group   = Etc.getgrgid(Etc.getpwnam(chruby['user']).gid).name

        r = Chef::Resource::RubyBuildRuby.new("#{ruby} (#{chruby['user']})",
          run_context)
        r.definition(ruby)
        r.prefix_path(opts['prefix_path'] || default_prefix)
        r.user(chruby['user'])
        r.group(opts['group'] || default_group)
        %w{environment action}.each do |attr|
          r.send(attr, opts[attr]) if opts[attr]
        end
        r.run_action(:install) if !flag_or_opts.nil? && !flag_or_opts == false

        r = Chef::Resource::File.new(::File.join(user_home, ".ruby-version"),
          run_context)
        r.user(chruby['user'])
        r.group(default_group)
        r.content("#{ruby}\n")
        r.run_action(:create) if opts['default'] == true
      end
    end
  end
end
