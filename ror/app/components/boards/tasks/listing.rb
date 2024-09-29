module Boards
  module Tasks
    class Listing < ViewComponent::Base
      with_collection_parameter :task

      def initialize(task:)
        @task = task
      end

      private

      attr_reader :task
    end
  end
end