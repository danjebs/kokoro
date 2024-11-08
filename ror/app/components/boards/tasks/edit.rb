class Boards::Tasks::Edit < BaseComponent
  def initialize(task:)
    @task = task
    @statuses = task.board.task_statuses
    @users = task.board.users
  end

  private

  attr_reader :task, :statuses, :users
end
