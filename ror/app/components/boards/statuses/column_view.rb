module Boards
  module Statuses
    class ColumnView < BaseComponent
      def initialize(task_status:, tasks:)
        @task_status = task_status
        @tasks = tasks
      end

      private

      attr_reader :task_status, :tasks
    end
  end
end
