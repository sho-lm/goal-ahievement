require 'test_helper'

class GoalsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @goal = Goal.new(content: "create goals test",
                      limit:  "2020-7-7"
                    )
  end

  # index --------------------------------------------------------------------------
  
  test "should get index" do
    get goals_path
    assert_response :success
  end
  
  # new ----------------------------------------------------------------------------
  
  test "should get new" do
    get new_goal_path
    assert_response :success
  end

  # create --------------------------------------------------------------------------

  test "should redirect when goal created" do
    assert_difference "Goal.count" do
      post goals_path, params: { goal: { content: "create test",
                                          limit: "2020-7-7" } }
    end
    assert_redirected_to goals_url
  end

end
