class Boards::Tasks::New < BaseComponent
  def initialize(task:)
    @task = task
  end

  private

  attr_reader :task
end
