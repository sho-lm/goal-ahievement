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
    
  end
  
  
  describe "POST #create" do
    context "with params are valid" do
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
    context "when params are invalid" do
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
    
  end

  describe "DELETE #destroy" do
    
  end
  
  
end
