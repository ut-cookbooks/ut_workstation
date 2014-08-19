require_relative "../spec_helper"

describe "ut_workstation::_ruby" do

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:runner) do
    ChefSpec::Runner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  before do
    stub_data_bag_item("users", "alpha").and_return(
      "chruby" => {}
    )
    stub_data_bag_item("users", "beta").and_return(
      "chruby" => {
        "rubies" => {
          "ruby-2.1.2" => {
            "default" => true
          },
          "ruby-1.8.7-p375" => {
            "prefix_path" => "/tmp/yep",
            "group" => "humans",
            "environment" => {
              "CONFIGURE_OPTS" => "--without-tcl --without-tk"
            }
          },
          "ruby-nadda" => false,
          "ruby-nilly" => nil
        }
      }
    )
    stub_data_bag_item("users", "nilly").and_return(
      "chruby" => nil
    )
    stub_data_bag_item("users", "skippy").and_return(
      "chruby" => false
    )

    node.set["users"] = %w[alpha beta nilly skippy]
    node.set["user"]["data_bag_name"] = "users"
  end

  it "includes the chruby recipe" do
    expect(chef_run).to include_recipe("chruby")
  end

  it "does not include the chruby recipe if no user requires it" do
    stub_data_bag_item("users", "alpha").and_return("chruby" => false)
    stub_data_bag_item("users", "beta").and_return("chruby" => false)

    expect(chef_run).to_not include_recipe("chruby")
  end

  it "includes the ruby_install recipe" do
    expect(chef_run).to include_recipe("ruby_install")
  end

  it "does not include the ruby_install recipe if no user requires it" do
    stub_data_bag_item("users", "alpha").and_return("chruby" => false)
    stub_data_bag_item("users", "beta").and_return("chruby" => false)

    expect(chef_run).to_not include_recipe("ruby_install")
  end

  describe "for mac platform" do

    let(:platform)  { "mac_os_x" }
    let(:version)   { "10.9.2" }

    it "fixes root group chown in execute resource (patch)" do
      expect(chef_run).to run_execute(
        "chown root:root /usr/local/bin/ruby-install"
      ).with(
        :command => "chown root:wheel /usr/local/bin/ruby-install"
      )
    end
  end

  it "installs a simple ruby version" do
    expect(chef_run).to install_ut_workstation_ruby("Ruby ruby-2.1.2 (beta)")
  end

  it "installs a ruby version with multiple attributes" do
    expect(chef_run).to install_ut_workstation_ruby(
      "Ruby ruby-1.8.7-p375 (beta)"
    ).with(
      :version      => "ruby-1.8.7-p375",
      :user         => "beta",
      :group        => "humans",
      :prefix_path  => "/tmp/yep",
      :environment  => { "CONFIGURE_OPTS" => "--without-tcl --without-tk" }
    )
  end

  it "skips ruby hashes that are falsy" do
    expect(chef_run).to_not install_ut_workstation_ruby(
      "Ruby ruby-nadda (beta)"
    )
    expect(chef_run).to_not install_ut_workstation_ruby(
      "Ruby ruby-nilly (beta)"
    )
  end
end
