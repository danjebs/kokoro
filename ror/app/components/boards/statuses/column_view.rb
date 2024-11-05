class Boards::Statuses::ColumnView < BaseComponent
  def initialize(task_status:)
    @task_status = task_status
  end

  private

  attr_reader :task_status
end
