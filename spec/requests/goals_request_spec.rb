require 'rails_helper'

RSpec.describe "Goals", type: :request do
  describe "#index" do
    it "returns http status 200" do
      get goals_path
      expect(response.status).to eq 200
    end
    it "shows goals list" do
      goal = create(:test_goal)
      get goals_path
      expect(response.body).to include "test goal"
    end
  end

  describe "#new" do
    it "returns http status 200" do
      get new_goal_path
      expect(response.status).to eq 200  
    end
  end
  
  describe "#describe" do
    context "with params are valid" do
      let(:params) { { goal: { content: "new test" } } }
      it "returns http status 302" do
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
      it "return http status 200" do
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
  
end
