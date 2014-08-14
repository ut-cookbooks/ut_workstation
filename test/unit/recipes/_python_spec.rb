require_relative "../spec_helper"

describe "ut_workstation::_python" do

  let(:runner) do
    ChefSpec::Runner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  shared_examples "common" do

    before do
      stub_data_bag_item("workstation", platform).and_return(
        "pip_packages" => {
          "alpha" => {},
          "beta" => {
            "version"     => "best",
            "virtualenv"  => "thatplace",
            "options"     => "all",
            "action"      => "remove"
          }
        }
      )
    end

    it "includes the python::pip recipe" do
      expect(chef_run).to include_recipe("python::pip")
    end

    it "installs a simple pip package" do
      expect(chef_run).to install_python_pip("alpha")
    end

    it "manages a pip package with multiple attributes" do
      expect(chef_run).to remove_python_pip("beta").with(
        :version    => "best",
        :virtualenv => "thatplace",
        :options    => "all"
      )
    end
  end

  describe "for ubuntu platforms" do

    let(:platform)  { "ubuntu" }
    let(:version)   { "14.04" }

    include_examples "common"
  end

  describe "for mac platforms" do

    let(:platform)  { "mac_os_x" }
    let(:version)   { "10.9.2" }

    include_examples "common"

    it "installs the python package" do
      expect(chef_run).to install_package("python")
    end

    it "symlinks python/bin to python" do
      expect(chef_run).to create_link("/usr/local/share/python/bin").with(
        :to => "/usr/local/share/python"
      )
    end
  end
end
