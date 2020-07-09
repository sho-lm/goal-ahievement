require 'rails_helper'

RSpec.describe "Goals", type: :request do
  describe "GET #index" do
    it "returns HTTP STATUS 200" do
      get goals_path
      expect(response.status).to eq 200
    end
    it "shows goals list" do
      goal = create(:test_goal)
      get goals_path
      expect(response.body).to include "test goal"
    end
  end

  describe "GET #show" do
    context "when specified goal exists" do
      let(:test_goal) { create(:test_goal) }
      it "returns HTTP STATUS 200" do
        get goal_path test_goal.id
        expect(response.status).to eq 200
      end
      it "showw goal content" do
        get goal_path test_goal.id
        expect(response.body).to include "test goal"
      end
    end
    context "when specified goal doesn't exist" do
      let(:not_exist_goal) { Goal.new(id: 0) }
      it "return HTTP STATUS 302" do
        get goal_path not_exist_goal.id
        expect(response.status).to eq 302  
      end
      it "redirects to goals_path" do
        get goal_path not_exist_goal.id
        expect(response).to redirect_to goals_path  
      end
    end
  end
  

  describe "GET#new" do
    it "returns HTTP STATUS 200" do
      get new_goal_path
      expect(response.status).to eq 200  
    end
  end

  describe "GET #edit" do
    context "when specified goal exists" do
      let(:test_goal) { create(:test_goal) }
      it "returns HTTP STATUS 200" do
        get edit_goal_path test_goal.id
        expect(response.status).to eq 200  
      end
      it "shows goal content" do
        get edit_goal_path test_goal.id
        expect(response.body).to include "test goal"  
      end
    end
    context "when specified goal doesn't exist" do
      let(:not_exist_goal) { Goal.new(id: 0) }
      it "returns HTTP STATUS 302" do
        get edit_goal_path not_exist_goal.id
        expect(response.status).to eq 302  
      end
      it "redirects goals_path" do
        get edit_goal_path not_exist_goal.id
        expect(response).to redirect_to goals_path  
      end
    end
  end
  
  
  describe "POST #create" do
    context "with valid params" do
      let(:params) { { goal: { content: "new test" } } }
      it "returns HTTP STATUS 302" do
        post goals_path, params: params
        expect(response.status).to eq 302  
      end
      it "creates new Goal" do
        expect do
          post goals_path, params: params
        end.to change(Goal, :count).by(1)
      end
      it "redirects to goals_path" do
        post goals_path, params: params
        expect(response).to redirect_to goals_path  
      end
    end
    context "with invalid params" do
      let(:params_invalid) { { goal: { content: nil } } }
      it "return HTTP STATUS 200" do
        post goals_path, params: params_invalid
        expect(response.status).to eq 200  
      end
      it "doesn't create new Goal" do
        expect do
          post goals_path, params: params_invalid
        end.not_to change(Goal, :count)
      end
      it "shows error message" do
        post goals_path, params: params_invalid
        expect(response.body).to include ERB::Util.h("Content can't be blank")
      end
    end
  end
  
  describe "PUT #update" do
    let(:english_goal) { create(:english_goal) }
    context "with valid params" do
      it "returns HTTP STATUS 302" do
        put goal_path english_goal, params: { goal: attributes_for(:math_goal) }
        expect(response.status).to eq 302  
      end
      it "updates goal content" do
        expect do
          put goal_path english_goal, params: { goal: attributes_for(:math_goal) }
        end.to change { Goal.find(english_goal.id).content }.from("study English").to("study math")
      end
      it "redirects goal_path" do
        put goal_path english_goal, params: { goal: attributes_for(:math_goal) }
        expect(response).to redirect_to goal_path english_goal.id  
      end
    end
    context "with invalid params" do
      it "returns HTTP STATUS 200" do
        put goal_path english_goal, params: { goal: { content: "" } }
        expect(response.status).to eq 200  
      end
      it "doesn't update goal content" do
        expect do
          put goal_path english_goal, params: { goal: { content: "" } }
        end.not_to change(Goal.find(english_goal.id), :content)
      end
    end
    context "when specified goal doesn't exist" do
      let(:not_exist_goal) { Goal.new(id: 0) }
      it "returns HTTP STATUS 302" do
        put goal_path not_exist_goal, params: { goal: { content: "not exist" } }
        expect(response.status).to eq 302  
      end
      it "redirects goals_path" do
        put goal_path not_exist_goal, params: { goal: { content: "not exist" } }
        expect(response).to redirect_to goals_path  
      end
    end
    
  end

  describe "DELETE #destroy" do
    context "when specified goal exists" do
      let(:test_goal) { create(:test_goal) }
      it "returns HTTP STATUS 302" do
        delete goal_path test_goal
        expect(response.status).to eq 302
      end
      it "destroys goal" do
        delete goal_path test_goal
        expect(Goal.find_by(id: test_goal.id)).to be_nil
      end
      it "redirects to goals_path" do
        delete goal_path test_goal
        expect(response).to redirect_to goals_path  
      end
    end
    context "when specified goal doesn't exist" do
      let(:not_exist_goal) { Goal.new(id: 0) }
      it "returs HTTP STATUS 302" do
        delete goal_path not_exist_goal
        expect(response.status).to eq 302
      end
      it "doesn't destroy any goals" do
        expect do
          delete goal_path not_exist_goal
        end.not_to change(Goal, :count)
      end
      it "redirects to goals_path" do
        delete goal_path not_exist_goal
        expect(response).to redirect_to goals_path  
      end
    end
  end
  
  
end
