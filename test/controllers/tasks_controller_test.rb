require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { assignee_id: @task.assignee_id, created_by: @task.created_by, description: @task.description, due_date: @task.due_date, section_id: @task.section_id, status: @task.status, title: @task.title } }
    end

    assert_redirected_to task_path(Task.last)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { assignee_id: @task.assignee_id, created_by: @task.created_by, description: @task.description, due_date: @task.due_date, section_id: @task.section_id, status: @task.status, title: @task.title } }
    assert_redirected_to task_path(@task)
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_path
  end
end
