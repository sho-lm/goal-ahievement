require 'rails_helper'

RSpec.describe Goal, type: :model do
  # default -----------------------------------------------------------------------------------------------------
  describe "default value" do
    context "when #new without arguments" do
      let(:goal) { Goal.new } 
      it "achievement_flag has default value" do
        expect(goal.achievement_flag).to eq false
      end
      it "progress has default value" do
        expect(goal.progress).to eq 0
      end
      it "hierarchy has default value" do
        expect(goal.hierarchy).to eq 1
      end
      it "children_length has default value" do
        expect(goal.children_length).to eq 0
      end
    end
    context "when #new with achievement_flag" do
      it "achievement_flag has specified value" do
        goal_ = Goal.new(achievement_flag: true)
        expect(goal_.achievement_flag).to eq true 
      end
    end
    context "when #new with progress" do
      it "progress has specified value" do
        goal_ = Goal.new(progress: 10)
        expect(goal_.progress).to eq 10  
      end
    end
    context "when #new with hierarchy" do
      it "hierarchy has specified value" do
        goal_ = Goal.new(hierarchy: 2)
        expect(goal_.hierarchy).to eq 2 
      end
    end
    context "when #new with children_length" do
      it "children_length has specified value" do
        goal_ = Goal.new(children_length: 3)
        expect(goal_.children_length).to eq 3  
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
    # achievement_flag-----------------------------
    context "when achievement_flag is blank" do
      it "is invalid" do
        test_goal.achievement_flag = nil
        expect(test_goal).not_to be_valid  
      end
    end
    # progress -------------------------------------
    context "when progress is blank" do
      it "is invalid" do
        test_goal.progress = nil
        expect(test_goal).not_to be_valid  
      end
    end
    context "when progress is in 0..100" do
      it "is valid" do
        test_goal.progress = 0
        expect(test_goal).to be_valid  
        test_goal.progress = 50
        expect(test_goal).to be_valid  
        test_goal.progress = 100
        expect(test_goal).to be_valid  
      end
    end
    context "when progress is out of 0..100" do
      it "is invalid" do
        test_goal.progress = -1
        expect(test_goal).not_to be_valid  
        test_goal.progress = 101
        expect(test_goal).not_to be_valid  
      end
    end
    # hierarchy -------------------------------------
    context "when hierarchy is blank" do
      it "is invalid" do
        test_goal.hierarchy = nil
        expect(test_goal).not_to be_valid  
      end
    end
    context "when hierarchy is in 1..3" do
      it "is valid" do
        test_goal.hierarchy = 1
        expect(test_goal).to be_valid  
        test_goal.hierarchy = 2
        expect(test_goal).to be_valid  
        test_goal.hierarchy = 3
        expect(test_goal).to be_valid  
      end
    end
    context "when hierarchy is out of 1..3" do
      it "is invalid" do
        test_goal.hierarchy = 0
        expect(test_goal).not_to be_valid  
        test_goal.hierarchy = 4
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
  # methods -----------------------------------------------------------------------------------------------
  describe "#progress_rate" do
    context "when called" do
      it "returns progress + %" do
        goal_ = Goal.new(progress: 10)
        expect(goal_.progress_rate).to eq "10%"  
        goal_.progress = 77
        expect(goal_.progress_rate).to eq "77%"  
      end
    end
  end
end
