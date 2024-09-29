module Boards
  module Tasks
    class New < ViewComponent::Base
      def initialize(task:)
        @task = task
      end
    end
  end
end