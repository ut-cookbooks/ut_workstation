require_relative "../spec_helper"

describe "ut_workstation::_packages" do

  let(:runner) do
    ChefSpec::SoloRunner.new(:platform => platform, :version => version)
  end

  let(:node)      { runner.node }
  let(:chef_run)  { runner.converge(described_recipe) }

  shared_examples "system packages" do

    describe "system packages" do

      before do
        stub_data_bag_item("workstation", platform).and_return(
          "system_packages" => {
            "alpha" => {},
            "beta" => {
              "version" => "best",
              "source" => "thatplace",
              "options" => "all",
              "action" => "remove"
            }
          }
        )
      end

      it "installs a simple package" do
        expect(chef_run).to install_package("alpha")
      end

      it "installs a package with multiple attribtes" do
        expect(chef_run).to remove_package("beta").with(
          :version  => "best",
          :source   => "thatplace",
          :options  => "all"
        )
      end
    end
  end

  describe "for debian platforms" do

    let(:platform)  { "debian" }
    let(:version)   { "7.6" }

    it "does not include the ubuntu recipe" do
      expect(chef_run).to_not include_recipe "ubuntu"
    end

    include_examples "system packages"
  end

  describe "for ubuntu platforms" do

    let(:platform)  { "ubuntu" }
    let(:version)   { "14.04" }

    it "includes the ubuntu recipe" do
      expect(chef_run).to include_recipe "ubuntu"
    end

    include_examples "system packages"
  end

  describe "for mac_os_x platforms" do

    let(:platform)  { "mac_os_x" }
    let(:version)   { "10.9.2" }

    before do
      stub_data_bag_item("workstation", platform).and_return(
        "homebrew_taps" => {
          "cool/beans" => {}
        },
        "zip_apps" => {
          "alpha" => {},
          "beta" => {
            "source" => "a",
            "zip_file" => "b",
            "destination" => "c",
            "checksum" => "d"
          }
        },
        "dmgs" => {
          "charlie" => {},
          "delta" => {
            "volumes_dir" => "e",
            "dmg_name" => "f",
            "destination" => "g",
            "type" => "h",
            "source" => "i",
            "checksum" => "j"
          }
        },
        "casks" => {
          "echo" => {},
          "foxtrot" => {
            "casked" => true,
            "action" => "uninstall"
          }
        }
      )

      original_exist = ::File.method(:exist?)
      allow(::File).to receive(:exist?) do |file|
        case file
        when "/usr/local/bin/mvim" then true
        else
          original_exist.call(file)
        end
      end
    end

    it "adds the homebrew/dupes tap" do
      expect(chef_run).to tap_homebrew_tap("homebrew/dupes")
    end

    it "includes the homebrew::cask recipe" do
      expect(chef_run).to include_recipe("homebrew::cask")
    end

    it "ensures cask directories are owned by homebrew owner" do
      node.set["homebrew"]["owner"] = "jdoe"
      allow_any_instance_of(Chef::Recipe).to receive(:homebrew_owner).
        and_return("jdoe")

      %w[/opt/homebrew-cask /opt/homebrew-cask/Caskroom].each do |dir|
        expect(chef_run).to create_directory(dir).with(:owner => "jdoe")
      end
    end

    it "add homebrew taps from homebrew_taps in workstation_data" do
      expect(chef_run).to tap_homebrew_tap("cool/beans")
    end

    it "includes the xquartz recipe" do
      expect(chef_run).to include_recipe("xquartz")
    end

    include_examples "system packages"

    it "installs a simple zip app" do
      expect(chef_run).to install_zip_app_package("alpha")
    end

    it "installs a zip app with multiple attribtes" do
      expect(chef_run).to install_zip_app_package("beta").with(
        :source       => "a",
        :zip_file     => "b",
        :destination  => "c",
        :checksum     => "d"
      )
    end

    it "installs a simple dmg app" do
      expect(chef_run).to install_dmg_package("charlie")
    end

    it "installs a dmg app with multiple attribtes" do
      expect(chef_run).to install_dmg_package("delta").with(
        :volumes_dir  => "e",
        :dmg_name     => "f",
        :destination  => "g",
        :type         => "h",
        :source       => "i",
        :checksum     => "j"
      )
    end

    it "installs a simple homebrew cask" do
      expect(chef_run).to install_homebrew_cask("echo")
    end

    it "installs a homebrew cask with multiple attribtes" do
      expect(chef_run).to uninstall_homebrew_cask("foxtrot").with(
        :casked  => true
      )
    end

    it "symlinks mvim to vim" do
      expect(chef_run).to create_link("/usr/local/bin/vim").with(
        :to => "/usr/local/bin/mvim"
      )
    end

    it "symlinks mvim to view" do
      expect(chef_run).to create_link("/usr/local/bin/view").with(
        :to => "/usr/local/bin/mvim"
      )
    end
  end
end
