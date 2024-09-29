module Boards
  module Tasks
    class Edit < ViewComponent::Base
      def initialize(task:)
        @task = task
      end
    end
  end
end