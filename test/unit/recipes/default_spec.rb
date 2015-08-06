require_relative "../spec_helper"

describe "ut_workstation::default" do

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:runner) do
    ChefSpec::SoloRunner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  before do
    stub_command("which sudo")
  end

  %w[
    _base _packages _vagrant _python _defaults _users _bashrc _homesick _ruby
  ].each do |recipe|
    it "includes the #{recipe} recipe" do
      expect(chef_run).to include_recipe "ut_workstation::#{recipe}"
    end
  end
end
