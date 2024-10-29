module Boards
  module Tasks
    class New < BaseComponent
      def initialize(task:)
        @task = task
      end

      private

      attr_reader :task
    end
  end
end