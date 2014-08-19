require_relative "../spec_helper"

describe "ut_workstation::_bashrc" do

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:runner) do
    ChefSpec::Runner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  before do
    stub_data_bag_item("users", "alpha").and_return(
      "bashrc" => {}
    )
    stub_data_bag_item("users", "beta").and_return(
      "bashrc" => {
        "update" => false
      }
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
    chef_run
    installs = node["bashrc"]["user_installs"].map { |d| d["user"] }

    expect(installs).to_not include("nilly")
    expect(installs).to_not include("skippy")
  end

  it "sets a default update => true for users" do
    chef_run
    user = node["bashrc"]["user_installs"].find { |d| d["user"] == "alpha" }

    expect(user).to eq("user" => "alpha", "update" => true)
  end

  it "sets a custom update value for users" do
    chef_run
    user = node["bashrc"]["user_installs"].find { |d| d["user"] == "beta" }

    expect(user).to eq("user" => "beta", "update" => false)
  end

  it "includes the bashrc::user recipe" do
    expect(chef_run).to include_recipe "bashrc::user"
  end
end
