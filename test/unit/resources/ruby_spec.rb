require "spec_helper"
load_resource("ut_workstation", "ruby")

describe Chef::Resource::UtWorkstationRuby do

  let(:resource_name) { "betta" }

  it "sets the default attribute to version" do
    expect(resource.version).to eq("betta")
  end

  it "attribute user is required" do
    expect { resource.user }.to raise_error(Chef::Exceptions::ValidationFailed)
  end

  it "attribute user takes a String value" do
    resource.user("yoda")

    expect(resource.user).to eq("yoda")
  end

  it "attribute group is nil by default" do
    expect(resource.group).to eq(nil)
  end

  it "attribute group takes a String value" do
    resource.group("rebels")

    expect(resource.group).to eq("rebels")
  end

  it "attribute prefix_path is nil by default" do
    expect(resource.prefix_path).to eq(nil)
  end

  it "attribute prefix_path takes a String value" do
    resource.prefix_path("/tmp")

    expect(resource.prefix_path).to eq("/tmp")
  end

  it "attribute environment is an empty Hash by default" do
    expect(resource.environment).to eq(Hash.new)
  end

  it "attribute environment takes a Hash value" do
    resource.environment("a" => "b")

    expect(resource.environment).to eq("a" => "b")
  end

  it "attribute default is false by default" do
    expect(resource.default).to eq(false)
  end

  it "attribute default takes a true value" do
    resource.default(true)

    expect(resource.default).to eq(true)
  end

  it "action defaults to :install" do
    expect(resource.action).to eq(:install)
  end
end
