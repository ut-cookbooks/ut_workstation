require_relative "../spec_helper"

describe "ut_workstation::_users" do

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:runner) do
    ChefSpec::SoloRunner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  it "includes the user::data_bag recipe" do
    expect(chef_run).to include_recipe "user::data_bag"
  end
end
