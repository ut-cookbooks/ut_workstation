require_relative "../spec_helper"

describe "ut_workstation::_base" do

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:runner) do
    ChefSpec::Runner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  before do
    stub_command("which sudo")
  end

  it "includes the ut_base recipe" do
    expect(chef_run).to include_recipe "ut_base"
  end
end
