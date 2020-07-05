require 'test_helper'

class GoalTest < ActiveSupport::TestCase
  def setup
    @goal = Goal.new(content:     "content",
                      limit:       "2020-7-7",
                      parent_id:   1,
                      user_id:     1
                    )
  end

  test "should be valid" do
    assert @goal.valid?
  end

  # presetn validate ----------------------------------------------------------------------

  test "content should be present" do
    @goal.content = ""
    assert_not @goal.valid?
  end

  test "achievement_flag should be present" do
    @goal.achievement_flag = nil
    assert_not @goal.valid?
  end

  test "progress should be present" do
    @goal.progress = nil
    assert_not @goal.valid?
  end

  test "parent_id should be present" do
    @goal.parent_id = nil
    assert_not @goal.valid?
  end

  test "hierarchy should be present" do
    @goal.hierarchy = nil
    assert_not @goal.valid?
  end

  test "children_length should be present" do
    @goal.children_length = nil
    assert_not @goal.valid?
  end

  test "user_id should be present" do
    @goal.user_id = nil
    assert_not @goal.valid?
  end

  # default value ----------------------------------------------------------------------

  test "achievement_flag should have default" do
    goal = Goal.new
    assert_equal false, goal.achievement_flag
    value = true
    goal = Goal.new(achievement_flag: value)
    assert_equal value, goal.achievement_flag
  end

  test "progress should have default" do
    goal = Goal.new
    assert_equal 0, goal.progress
    value = 50
    goal = Goal.new(progress: value)
    assert_equal value, goal.progress
  end
  
  test "hierarchy should have default" do
    goal = Goal.new
    assert_equal 1, goal.hierarchy
    value = 7
    goal = Goal.new(hierarchy: value)
    assert_equal value, goal.hierarchy
  end
  
  test "children_length should have default" do
    goal = Goal.new
    assert_equal 0, goal.children_length
    value = 2
    goal = Goal.new(children_length: value)
    assert_equal value, goal.children_length
  end

  # maximum minimum length -------------------------------------------------------

  test "progress should be between 0 and 100" do
    @goal.progress = 0
    assert @goal.valid?
    @goal.progress = 100
    assert @goal.valid?
    @goal.progress = -1
    assert_not @goal.valid?
    @goal.progress = 101
    assert_not @goal.valid?
  end

  test "hierarchy should be in [1 2 3]" do
    @goal.hierarchy = 1
    assert @goal.valid?
    @goal.hierarchy = 2
    assert @goal.valid?
    @goal.hierarchy = 3
    assert @goal.valid?
    @goal.hierarchy = 0
    assert_not @goal.valid?
    @goal.hierarchy = 4
    assert_not @goal.valid?
  end

  # methods ----------------------------------------------------------------------

  test "progress_rate should return { progress + % }" do
    progress = 20
    goal = Goal.new(progress: progress)
    assert_equal "#{progress}%", goal.progress_rate
    progress = 100
    goal.progress = progress
    assert_equal "#{progress}%", goal.progress_rate
  end
end
