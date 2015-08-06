require_relative "../spec_helper"
require_relative "../../../libraries/resource_ut_workstation_ruby"
require_relative "../../../libraries/provider_ut_workstation_ruby"

describe Chef::Provider::UtWorkstationRuby do

  let(:resource_name) { "ruby-2.1.2" }

  before do
    using_lw_resource("ruby_install", "ruby")

    new_resource.user("jdoe")

    allow(Etc).to receive(:getpwnam).with("jdoe") do
      double(:gid => 101, :dir => "/export/homes/jdoe")
    end
    allow(Etc).to receive(:getgrgid).with(101) do
      double(:name => "ppl")
    end
  end

  it "is whyrun support" do
    expect(provider).to be_whyrun_supported
  end

  context "for :install action" do

    let(:action) { :install }

    before { new_resource.action(action) }

    describe "installs a ruby" do

      let(:resource) { provider.manage_ruby(:install) }

      it "sets the name" do
        expect(resource.name).to eq("ruby-2.1.2 (jdoe)")
      end

      it "sets the version" do
        expect(resource.definition).to eq("ruby 2.1.2")
      end

      it "sets the user" do
        expect(resource.user).to eq("jdoe")
      end

      it "sets the group" do
        new_resource.group("jedi")

        expect(resource.group).to eq("jedi")
      end

      it "sets the group to the user's gid by default" do
        expect(resource.group).to eq("ppl")
      end

      it "sets the prefix path" do
        new_resource.prefix_path("/tmp/rubies")

        expect(resource.prefix_path).to eq("/tmp/rubies")
      end

      it "sets the prefix path for a user by default in their home dir" do
        expect(resource.prefix_path).to eq("/export/homes/jdoe/.rubies")
      end

      it "sets the environment by default" do
        expect(resource.environment).to eq(
          "USER"  => "jdoe",
          "HOME"  => "/export/homes/jdoe"
        )
      end

      it "merges default environment with provided overrides" do
        new_resource.environment("HOME" => "/tmp/jdoe", "A" => "B")

        expect(resource.environment).to eq(
          "USER"  => "jdoe",
          "HOME"  => "/tmp/jdoe",
          "A"     => "B"
        )
      end

      it "adds the resource to the resource collection" do
        provider.run_action(action)

        expect(runner_resources).to include(
          "ruby_install_ruby[ruby-2.1.2 (jdoe)]"
        )
      end
    end

    describe "sets a default ruby" do

      let(:resource) { provider.manage_ruby_version_file(:create) }

      it "sets the path" do
        expect(resource.path).to eq("/export/homes/jdoe/.ruby-version")
      end

      it "sets the user" do
        expect(resource.user).to eq("jdoe")
      end

      it "sets the group" do
        new_resource.group("jedi")

        expect(resource.group).to eq("jedi")
      end

      it "sets the group to the user's gid by default" do
        expect(resource.group).to eq("ppl")
      end

      it "sets the content" do
        expect(resource.content).to eq("ruby-2.1.2\n")
      end

      it "adds the resource to the resource collection if default is true" do
        new_resource.default(true)
        provider.run_action(action)

        expect(runner_resources).to include(
          "file[/export/homes/jdoe/.ruby-version]"
        )
      end

      it "does not add the resource if default is false" do
        new_resource.default(false)
        provider.run_action(action)

        expect(runner_resources).to_not include(
          "file[/export/homes/jdoe/.ruby-version]"
        )
      end
    end
  end
end
