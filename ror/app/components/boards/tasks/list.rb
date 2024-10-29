class Boards::Tasks::List < BaseComponent
  def initialize(tasks:, pagy:)
    @tasks = tasks
    @pagy = pagy
  end

  private

  attr_reader :tasks, :pagy
end
