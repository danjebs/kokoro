module Boards
  module Tasks
    class List < ViewComponent::Base
      def initialize(tasks:)
        @tasks = tasks
      end

      private

      attr_reader :tasks
    end
  end
end
