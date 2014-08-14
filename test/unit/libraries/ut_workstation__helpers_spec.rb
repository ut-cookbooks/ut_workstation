require_relative "../../../libraries/ut_workstation__helpers"

require "chef/node"
require "chef/platform"
require "fauxhai"

describe UTWorkstation::Helpers do

  include UTWorkstation::Helpers

  let(:platform)  { "ubuntu" }
  let(:version)   { "14.04" }

  let(:node) do
    n = Chef::Node.new
    n.consume_external_attrs(
      Mash.new(Fauxhai.mock(:platform => platform, :version => version).data),
      Mash.new
    )
    n
  end

  describe ".workstation_data" do

    it "returns nil with no data" do
      expect(workstation_data).to eq(nil)
    end

    it "returns value from workstation_data key in node run_state" do
      node.run_state["workstation_data"] = "some stuff"

      expect(workstation_data).to eq("some stuff")
    end
  end

  describe ".workstation_users" do

    it "returns nil with no data" do
      expect(workstation_users).to eq(nil)
    end

    it "returns value from workstation_users key in node run_state" do
      node.run_state["workstation_users"] = "some stuff"

      expect(workstation_users).to eq("some stuff")
    end
  end

  describe ".load_workstation_data!" do

    it "loads hash from a data bag platform workstation item" do
      load_workstation_data!

      expect(workstation_data).to eq("workstation" => "ubuntu")
    end

    it "loads an empty hash if the item could not be loaded" do
      allow(self).to receive(:data_bag_item) { raise "oops" }
      load_workstation_data!

      expect(workstation_data).to eq(Hash.new)
    end
  end

  describe ".load_workstation_users!" do

    before do
      node.set["user"]["user_array_node_attr"] = "some/user_accounts"
      node.set["user"]["data_bag_name"] = "dem_users"
      node.set["some"]["user_accounts"] = %w[alpha beta]
    end

    it "loads hash composed of user data bag items" do
      load_workstation_users!

      expect(workstation_users).to eq(
        "alpha" => { "dem_users" => "alpha" },
        "beta"  => { "dem_users" => "beta" }
      )
    end

    it "loads an empty hash for any non-existent user data bag items" do
      allow(self).to receive(:data_bag_item) { raise "oops" }
      load_workstation_users!

      expect(workstation_users).to eq("alpha" => {}, "beta" => {})
    end
  end

  private

  def data_bag_item(bag, item)
    { bag => item }
  end
end
