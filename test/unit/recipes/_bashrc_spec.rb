require_relative "../spec_helper"

describe "ut_workstation::_bashrc" do

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:runner) do
    ChefSpec::SoloRunner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  before do
    stub_data_bag_item("users", "alpha").and_return(
      "bashrc" => {}
    )
    stub_data_bag_item("users", "beta").and_return(
      "bashrc" => true
    )
    stub_data_bag_item("users", "nilly").and_return(
      "bashrc" => nil
    )
    stub_data_bag_item("users", "skippy").and_return(
      "bashrc" => false
    )

    node.set["users"] = %w[alpha beta nilly skippy]
    node.set["user"]["data_bag_name"] = "users"
  end

  it "drops users with a falsy bashrc sub-hash" do
    expect(chef_run).to_not install_bashrc("nilly")
    expect(chef_run).to_not install_bashrc("skippy")
  end

  it "installs bashrc for users with a truthy hash value" do
    expect(chef_run).to install_bashrc("alpha")
    expect(chef_run).to install_bashrc("beta")
  end
end
