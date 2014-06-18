require 'test_helper'

class TogglingTasksTest < ActionDispatch::IntegrationTest
  test 'can mark incomplete task as complete on index page' do
    undone = Task.create!(name: "You Must Complete Me!")
    get '/tasks'
    assert_response :success

    patch "/tasks/#{undone.id}", { completed_flag: true }, from_task_index
    assert_redirected_to(controller: "tasks", action: "index")
    assert(Task.find(undone.id).completed_flag)
  end

  test 'can mark incomplete task as complete on task page' do
    undone = Task.create!(name: "You Must Complete Me!")
    get "/tasks/#{undone.id}"
    assert_response :success

    patch "/tasks/#{undone.id}", { completed_flag: true }, from_task_page(undone)
    assert_redirected_to(controller: "tasks", action: "show")
    assert(Task.find(undone.id).completed_flag)
  end

  test 'can mark complete task as incomplete on index page' do
    done = Task.create!(name: "I'm not resolved yet!",
                        completed_flag: true)
    get '/tasks'
    assert_response :success

    patch "/tasks/#{done.id}", { completed_flag: false }, from_task_index
    assert_redirected_to(controller: "tasks", action: "index")
    assert_not(Task.find(done.id).completed_flag)
  end

  test 'can mark complete task as incomplete on task page' do
    done = Task.create!(name: "I'm not resolved yet!",
                        completed_flag: true)
    get "/tasks/#{done.id}"
    assert_response :success

    patch "/tasks/#{done.id}", { completed_flag: false }, from_task_page(done)
    assert_redirected_to(controller: "tasks", action: "show")
    assert_not(Task.find(done.id).completed_flag)
  end

  def from_task_index
    { 'HTTP_REFERER' => "/tasks" }
  end

  def from_task_page task
    { 'HTTP_REFERER' => "/tasks/#{task.id}" }
  end
end