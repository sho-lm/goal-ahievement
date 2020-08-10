require 'rails_helper'

RSpec.describe "Api::V1::Goals", type: :request do
  let(:sally) { create(:sally) }
  let(:sally_goal) { sally.goals.create(content: "sally goal") }
  let(:sally_login_params) { { name: sally.name, password: sally.password } }
  
  # index -----------------------------------------------------------------------------------------
  describe "GET #index" do
    context "when haven't logged in" do
      it "returns status 401" do
        get api_v1_user_goals_path(sally)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          get api_v1_user_goals_path(tom)
          expect(response.status).to eq 403
        end
        it "returns error message" do
          get api_v1_user_goals_path(tom)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
      end
      context "when specified user is current_user" do
        it "returns status 200" do
          get api_v1_user_goals_path(sally)
          expect(response.status).to eq 200  
        end
        it "returns goal list" do
          sally.goals.create(content: "goal1")
          get api_v1_user_goals_path(sally)
          res_json = JSON.parse(response.body)
          expect(res_json[0]["content"]).to eq "goal1"
        end
      end
    end
  end
  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
    context "when haven't logged in" do
      it "returns status 401" do
        post api_v1_user_goals_path(sally)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          post api_v1_user_goals_path(tom)
          expect(response.status).to eq 403
        end
        it "returns error message" do
          post api_v1_user_goals_path(tom)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { goal: { content: nil } } }
        it "returns status 400" do
          post api_v1_user_goals_path(sally), params: invalid_params
          expect(response.status).to eq 400  
        end
        it "returns error message" do
          post api_v1_user_goals_path(sally), params: invalid_params
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "invalid params"
        end
        it "doesn't create new goal" do
          expect do
            post api_v1_user_goals_path(sally), params: invalid_params
          end.not_to change(Goal, :count)
        end
      end
      context "when request params are valid" do
        let(:goal_params) { { goal: { content: "goal" } }  }
        it "returns status 201" do
          post api_v1_user_goals_path(sally), params: goal_params
          expect(response.status).to eq 201  
        end
        it "returns created goal" do
          post api_v1_user_goals_path(sally), params: goal_params
          res_json = JSON.parse(response.body)
          expect(res_json["content"]).to eq "goal"  
        end
        it "creates new goal" do
          expect do
            post api_v1_user_goals_path(sally), params: goal_params
          end.to change(Goal, :count).by(1)
        end
      end
    end
  end
  # update ----------------------------------------------------------------------------------------
  describe "PATCH #update" do
    context "when haven't logged in" do
      it "returns status 401" do
        patch api_v1_user_goal_path(sally, sally_goal)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          patch api_v1_user_goal_path(tom, sally_goal)
          expect(response.status).to eq 403 
        end
        it "returns error message" do
          patch api_v1_user_goal_path(tom, sally_goal)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
      end
      context "when specified user doesn't own specified goal" do
        let(:tom) { create(:tom) }
        let(:tom_goal) { tom.goals.create(content: "tom goal") }
        it "returns status 404" do
          patch api_v1_user_goal_path(sally, tom_goal)
          expect(response.status).to eq 404  
        end
        it "returns error message" do
          patch api_v1_user_goal_path(sally, tom_goal)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "goal not found"  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { goal: { content: nil } } }
        it "returns status 400" do
          patch api_v1_user_goal_path(sally, sally_goal), params: invalid_params
          expect(response.status).to eq 400  
        end
        it "returns error message" do
          patch api_v1_user_goal_path(sally, sally_goal), params: invalid_params
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "invalid params"
        end
        it "doesn't update goal" do
          expect do
            patch api_v1_user_goal_path(sally, sally_goal), params: invalid_params
          end.not_to change{ sally_goal.reload.content }
        end
      end
      context "when request params are valid" do
        let(:update_params) { { goal: { content: "updated" } }  }
        it "returns status 200" do
          patch api_v1_user_goal_path(sally, sally_goal), params: update_params
          expect(response.status).to eq 200  
        end
        it "returns updated goal" do
          patch api_v1_user_goal_path(sally, sally_goal), params: update_params
          res_json = JSON.parse(response.body)
          expect(res_json["content"]).to eq "updated"
        end
        it "updates goal" do
          expect do
            patch api_v1_user_goal_path(sally, sally_goal), params: update_params
          end.to change{ sally_goal.reload.content }.from("sally goal").to("updated")
        end
      end
    end
  end
  # destroy ---------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when haven't logged in" do
      it "returns status 401" do
        delete api_v1_user_goal_path(sally, sally_goal)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          delete api_v1_user_goal_path(tom, sally_goal)
          expect(response.status).to eq 403
        end
        it "returns error message" do
          delete api_v1_user_goal_path(tom, sally_goal)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
      end
      context "when specified user doesn't own specified goal" do
        let(:tom) { create(:tom) }
        let(:tom_goal) { tom.goals.create(content: "tom goal") }
        it "returns status 404" do
          delete api_v1_user_goal_path(sally, tom_goal)
          expect(response.status).to eq 404  
        end
        it "returns error message" do
          delete api_v1_user_goal_path(sally, tom_goal)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "goal not found"
        end
        it "doesn't destroy goal" do
          delete api_v1_user_goal_path(sally, tom_goal)
          expect(Goal.find_by(id: tom_goal.id)).not_to be_nil  
        end
      end
      context "when specified user owns specified goal" do
        it "returns status 200" do
          delete api_v1_user_goal_path(sally, sally_goal)
          expect(response.status).to eq 200
        end
        it "destroys goal" do
          delete api_v1_user_goal_path(sally, sally_goal)
          expect(Goal.find_by(id: sally_goal.id)).to be_nil 
        end
      end
    end
  end
end
