require "application_system_test_case"

class TaskStatusesTest < ApplicationSystemTestCase
  setup do
    @task_status = task_statuses(:one)
  end

  test "visiting the index" do
    visit task_statuses_url
    assert_selector "h1", text: "Task statuses"
  end

  test "should create task status" do
    visit task_statuses_url
    click_on "New task status"

    fill_in "Color", with: @task_status.color
    fill_in "Name", with: @task_status.name
    fill_in "Position", with: @task_status.position
    fill_in "State", with: @task_status.state
    click_on "Create Task status"

    assert_text "Task status was successfully created"
    click_on "Back"
  end

  test "should update Task status" do
    visit task_status_url(@task_status)
    click_on "Edit this task status", match: :first

    fill_in "Color", with: @task_status.color
    fill_in "Name", with: @task_status.name
    fill_in "Position", with: @task_status.position
    fill_in "State", with: @task_status.state
    click_on "Update Task status"

    assert_text "Task status was successfully updated"
    click_on "Back"
  end

  test "should destroy Task status" do
    visit task_status_url(@task_status)
    click_on "Destroy this task status", match: :first

    assert_text "Task status was successfully destroyed"
  end
end
