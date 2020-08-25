require 'rails_helper'

RSpec.describe Goal, type: :model do
  # default -----------------------------------------------------------------------------------------------------
  describe "default value" do
    context "when #new without arguments" do
      let(:goal) { Goal.new } 
      it "is_finished has default value" do
        expect(goal.is_finished).to eq false
      end
    end
    context "when #new with is_finished" do
      it "is_finished has specified value" do
        goal_ = Goal.new(is_finished: true)
        expect(goal_.is_finished).to eq true 
      end
    end
  end
  # validates ------------------------------------------------------------------------------------------------
  describe "validates" do
    let(:test_goal) { create(:test_goal) }
    context "with correct attributes" do
      it "is valid" do
        expect(test_goal).to be_valid  
      end
    end
    # content -------------------------------------
    context "when content is blank" do
      it "is invalid" do
        test_goal.content = nil
        expect(test_goal).not_to be_valid  
      end
    end
    context "when content length is less than or equal to 20" do
      it "is valid" do
        test_goal.content = "a" * 20
        expect(test_goal).to be_valid  
      end
    end
    
    context "when content length is greater than 20" do
      it "is invalid" do
        test_goal.content = "a" * 21
        expect(test_goal).not_to be_valid  
      end
    end
    # color --------------------------------------
    context "when color is blank" do
      it "is invalid" do
        test_goal.color = nil
        expect(test_goal).not_to be_valid  
      end
    end
    # is_finished --------------------------------
    context "when is_finished is blank" do
      it "is invalid" do
        test_goal.is_finished = nil
        expect(test_goal).not_to be_valid  
      end
    end
    # user_id ----------------------------------------
    context "when user_id is blank" do
      it "is invalid" do
        test_goal.user_id = nil
        expect(test_goal).not_to be_valid  
      end
    end
  end
end
