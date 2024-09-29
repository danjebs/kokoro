module Boards
  module Tasks
    class NewComponent < ViewComponent::Base
      def initialize(task:)
        @task = task
      end
    end
  end
end