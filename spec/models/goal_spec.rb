require 'rails_helper'

RSpec.describe Goal, type: :model do


  describe "#default" do
    context "without arguments" do
      let(:goal) { Goal.new } 
      it "achievement_flag has default value" do
        expect(goal.achievement_flag).to be_falsy
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
      it "user_id has default value" do
        expect(goal.user_id).to eq 1
      end
    end
    context "with achievement_flag" do
      it "achievement_flag has specified value" do
        goal_ = Goal.new(achievement_flag: true)
        expect(goal_.achievement_flag).to be_truthy  
      end
    end
    context "with progress" do
      it "progress has specified value" do
        goal_ = Goal.new(progress: 10)
        expect(goal_.progress).to eq 10  
      end
    end
    context "with hierarchy" do
      it "hierarchy has specified value" do
        goal_ = Goal.new(hierarchy: 2)
        expect(goal_.hierarchy).to eq 2 
      end
    end
    context "with children_length" do
      it "children_length has specified value" do
        goal_ = Goal.new(children_length: 3)
        expect(goal_.children_length).to eq 3  
      end
    end
    context "with user_id" do
      it "user_id has specified value" do
        goal_ = Goal.new(user_id: 4)
        expect(goal_.user_id).to eq 4
      end
    end
  end

  describe "#validates" do
    let(:goal) { Goal.new(content: "content") }
    context "with content" do
      it "is valid" do
        expect(goal).to be_valid  
      end
    end
    context "with no content" do
      it "is invalid" do
        goal.content = nil
        expect(goal).not_to be_valid  
      end
    end
    context "with no achievement_flag" do
      it "is invalid" do
        goal.achievement_flag = nil
        expect(goal).not_to be_valid  
      end
    end
    context "with no progress" do
      it "is invalid" do
        goal.progress = nil
        expect(goal).not_to be_valid  
      end
    end
    context "with no hierarchy" do
      it "is invalid" do
        goal.hierarchy = nil
        expect(goal).not_to be_valid  
      end
    end
    context "with no user_id" do
      it "is invalid" do
        goal.user_id = nil
        expect(goal).not_to be_valid  
      end
    end

    context "when progress is in 0..100" do
      it "is valid" do
        goal.progress = 0
        expect(goal).to be_valid  
        goal.progress = 50
        expect(goal).to be_valid  
        goal.progress = 100
        expect(goal).to be_valid  
      end
    end
    context "when progress is out of 0..100" do
      it "is invalid" do
        goal.progress = -1
        expect(goal).not_to be_valid  
        goal.progress = 101
        expect(goal).not_to be_valid  
      end
    end

    context "when hierarchy is in 1..3" do
      it "is valid" do
        goal.hierarchy = 1
        expect(goal).to be_valid  
        goal.hierarchy = 2
        expect(goal).to be_valid  
        goal.hierarchy = 3
        expect(goal).to be_valid  
      end
    end
    context "when hierarchy is out of 1..3" do
      it "is invalid with 0" do
        goal.hierarchy = 0
        expect(goal).not_to be_valid  
        goal.hierarchy = 4
        expect(goal).not_to be_valid  
      end
    end
  end

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
