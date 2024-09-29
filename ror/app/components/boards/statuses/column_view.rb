module Boards
  module Statuses
    class ColumnView < ViewComponent::Base
      with_collection_parameter :task_status

      def initialize(task_status:)
        @task_status = task_status
      end

      private

      attr_reader :task_status
    end
  end
end
