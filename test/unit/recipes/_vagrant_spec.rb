require_relative "../spec_helper"

describe "ut_workstation::_vagrant" do

  let(:runner) do
    ChefSpec::SoloRunner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  shared_examples "recipe includes" do

    it "includes the virtualbox recipe, if node attribute is truthy" do
      node.set["ut_workstation"]["install_virtualbox"] = true

      expect(chef_run).to include_recipe("virtualbox")
    end

    it "does not include the virtualbox recipe, if node attribute is falsey" do
      node.set["ut_workstation"]["install_virtualbox"] = false

      expect(chef_run).to_not include_recipe("virtualbox")
    end
  end

  describe "for ubuntu platforms" do

    let(:platform)  { "ubuntu" }
    let(:version)   { "14.04" }

    include_examples "recipe includes"
  end

  describe "for mac platforms" do

    let(:platform)  { "mac_os_x" }
    let(:version)   { "10.9.2" }

    include_examples "recipe includes"

    it "sets the virtualbox url from ut_workstation node attribute" do
      node.set["ut_workstation"]["virtualbox"]["dmg"] =
        "http://download.virtualbox.org/virtualbox/4.3.6/VirtualBox-4.3.6-91406-OSX.dmg"
      chef_run

      expect(node["virtualbox"]["url"]).to eq(
        "http://download.virtualbox.org/virtualbox/4.3.6/VirtualBox-4.3.6-91406-OSX.dmg")
    end
  end
end
