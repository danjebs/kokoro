module Boards
  module Tasks
    class Show < ViewComponent::Base
      def initialize(task:)
        @task = task
      end

      private

      attr_reader :task
    end
  end
end