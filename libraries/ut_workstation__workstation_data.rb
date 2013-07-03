module UTWorkstation

  module Helpers

    def workstation_data
      node.run_state["workstation_data"] ||= Hash.new
    end
  end
end
