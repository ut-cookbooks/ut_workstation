require_relative "../spec_helper"

describe "ut_workstation::_defaults" do

  let(:runner) do
    ChefSpec::Runner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  let(:platform)  { "mac_os_x" }
  let(:version)   { "10.9.2" }

  before do
    stub_data_bag_item("workstation", platform).and_return(
      "userdefaults" => {
        "alpha" => {},
        "beta" => {
          "domain"  => "a",
          "key"     => "b",
          "value"   => "c",
          "type"    => "d",
          "user"    => "e"
        },
        "docka" => {
          "domain" => "com.apple.dock"
        },
        "sudoy" => {
          "domain" => "/Library/Preferences/foo"
        },
        "globy" => {
          "domain" => "NSGlobalDomain"
        }
      }
    )
  end

  it "includes the mac_os_x recipe" do
    expect(chef_run).to include_recipe("mac_os_x")
  end

  it "writes a simple mac user default" do
    expect(chef_run).to write_mac_os_x_userdefaults("alpha")
  end

  it "manages a mac user default with multiple attributes" do
    expect(chef_run).to write_mac_os_x_userdefaults("beta").with(
      :domain => "a",
      :key    => "b",
      :value  => "c",
      :type   => "d",
      :user   => "e"
    )
  end

  it "default with an NSGlobalDomain sets the global attribute" do
    expect(chef_run).to write_mac_os_x_userdefaults("globy").with(:global => true)
  end

  it "default with a /Library/Preferences/ domain sets the sudo attribute" do
    expect(chef_run).to write_mac_os_x_userdefaults("sudoy").with(:sudo => true)
  end

  it "default with the dock domain restarts the dock" do
    resource = chef_run.mac_os_x_userdefaults("docka")

    expect(resource).to notify("execute[killall Dock]").to(:run)
  end
end
