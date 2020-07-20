require 'rails_helper'

RSpec.describe "Goals", type: :request do
  let(:sally) { create(:sally) }
  let(:sally_goal) { sally.goals.create(content: "sally goal") }
  let(:sally_login_params) { { session: { account_id: sally.account_id, password: sally.password } } }
  # index -----------------------------------------------------------------------------------------
  describe "GET #index" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get user_goals_path(sally)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get user_goals_path(sally)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get user_goals_path(tom)
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
          get user_goals_path(tom)
          expect(response).to redirect_to root_path
        end
      end
      context "when specified user is current_user" do
        it "returns HTTP STATUS 200" do
          get user_goals_path(sally)
          expect(response.status).to eq 200
        end
        it "shows goals list" do
          sally.goals.create(content: "sally goal")
          get user_goals_path(sally)
          expect(response.body).to include "sally goal"
        end
      end
    end
  end

  # new ------------------------------------------------------------------------------------------
  describe "GET#new" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get new_user_goal_path(sally)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get new_user_goal_path(sally)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get new_user_goal_path(tom)
          expect(response.status).to eq 302  
        end
        it "redirects to root_path" do
          get new_user_goal_path(tom)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified user is current_user" do
        it "returns HTTP STATUS 200" do
          get new_user_goal_path(sally)
          expect(response.status).to eq 200  
        end
      end
    end
  end

  # show ------------------------------------------------------------------------------------------
  describe "GET #show" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get user_goal_path(sally, sally_goal)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get user_goal_path(sally, sally_goal)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get user_goal_path(tom, sally_goal)
          expect(response.status).to eq 302  
        end
        it "redirects to root_path" do
          get user_goal_path(tom, sally_goal)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal doesn't exist" do
        let(:not_exist_goal) { sally.goals.build(id: -1, content: "not exist goal") }
        it "return HTTP STATUS 302" do
          get user_goal_path(sally, not_exist_goal)
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          get user_goal_path(sally, not_exist_goal)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal exists" do
        it "returns HTTP STATUS 200" do
          get user_goal_path(sally, sally_goal)
          expect(response.status).to eq 200
        end
        it "shows goal content" do
          get user_goal_path(sally, sally_goal)
          expect(response.body).to include "sally goal"
        end
      end
    end
  end

  # edit ------------------------------------------------------------------------------------------
  describe "GET #edit" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get edit_user_goal_path(sally, sally_goal)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get edit_user_goal_path(sally, sally_goal)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get edit_user_goal_path(tom, sally_goal)
          expect(response.status).to eq 302  
        end
        it "redirects to root_path" do
          get edit_user_goal_path(tom, sally_goal)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal doesn't exist" do
        let(:not_exist_goal) { sally.goals.build(id: -1, content: "not exist goal") }
        it "return HTTP STATUS 302" do
          get edit_user_goal_path(sally, not_exist_goal)
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          get edit_user_goal_path(sally, not_exist_goal)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal exists" do
        it "returns HTTP STATUS 200" do
          get edit_user_goal_path(sally, sally_goal)
          expect(response.status).to eq 200  
        end
        it "shows goal content" do
          get edit_user_goal_path(sally, sally_goal)
          expect(response.body).to include "sally goal"  
        end
      end
    end
  end
  
  # create ------------------------------------------------------------------------------------------
  describe "POST #create" do
    let(:goal_params) { { goal: { content: "goal" } }  }
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        post user_goals_path(sally), params: goal_params
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        post user_goals_path(sally), params: goal_params
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          post user_goals_path(tom), params: goal_params
          expect(response.status).to eq 302  
        end
        it "redirects to root_path" do
          post user_goals_path(tom), params: goal_params
          expect(response).to redirect_to root_path  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { goal: { content: nil } } }
        it "return HTTP STATUS 200" do
          post user_goals_path(sally), params: invalid_params
          expect(response.status).to eq 200  
        end
        it "doesn't create goal" do
          expect do
            post user_goals_path(sally), params: invalid_params
          end.not_to change(Goal, :count)
        end
        it "shows error message" do
          post user_goals_path(sally), params: invalid_params
          expect(response.body).to include ERB::Util.h("Content can't be blank")
        end
      end
      context "when request params are valid" do
        it "returns HTTP STATUS 302" do
          post user_goals_path(sally), params: goal_params
          expect(response.status).to eq 302  
        end
        it "creates goal" do
          expect do
            post user_goals_path(sally), params: goal_params
          end.to change(Goal, :count).by(1)
        end
        it "redirects to to user_goals_path" do
          post user_goals_path(sally), params: goal_params
          expect(response).to redirect_to user_goals_path(sally)  
        end
      end
    end
  end
  
  # update ------------------------------------------------------------------------------------------
  describe "PUT #update" do
    let(:update_params) { { goal: { content: "updated" } }  }
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        put user_goal_path(sally, sally_goal), params: update_params
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        put user_goal_path(sally, sally_goal), params: update_params
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          put user_goal_path(tom, sally_goal), params: update_params
          expect(response.status).to eq 302  
        end
        it "redirects to root_path" do
          put user_goal_path(tom, sally_goal), params: update_params
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal doesn't exist" do
        let(:not_exist_goal) { sally.goals.build(id: -1, content: "not exist goal") }
        it "return HTTP STATUS 302" do
          put user_goal_path(sally, not_exist_goal), params: update_params
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          put user_goal_path(sally, not_exist_goal), params: update_params
          expect(response).to redirect_to root_path  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { goal: { content: nil } } }
        it "return HTTP STATUS 200" do
          put user_goal_path(sally, sally_goal), params: invalid_params
          expect(response.status).to eq 200  
        end
        it "doesn't update goal" do
          expect do
            put user_goal_path(sally, sally_goal), params: invalid_params
          end.not_to change{ sally_goal.reload.content }
        end
        it "shows error message" do
          put user_goal_path(sally, sally_goal), params: invalid_params
          expect(response.body).to include ERB::Util.h("Content can't be blank")
        end
      end
      context "when request params are valid" do
        it "returns HTTP STATUS 302" do
          put user_goal_path(sally, sally_goal), params: update_params
          expect(response.status).to eq 302  
        end
        it "updates goal content" do
          expect do
            put user_goal_path(sally, sally_goal), params: update_params
          end.to change { sally_goal.reload.content }.from("sally goal").to("updated")
        end
        it "redirects to user_goals_path" do
          put user_goal_path(sally, sally_goal), params: update_params
          expect(response).to redirect_to user_goals_path(sally)
        end
      end
    end
  end

  # destroy ------------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        delete user_goal_path(sally, sally_goal)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        delete user_goal_path(sally, sally_goal)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
        delete user_goal_path(tom, sally_goal)
          expect(response.status).to eq 302  
        end
        it "redirects to root_path" do
        delete user_goal_path(tom, sally_goal)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal doesn't exist" do
        let(:not_exist_goal) { sally.goals.build(id: -1, content: "not exist goal") }
        it "return HTTP STATUS 302" do
          delete user_goal_path(sally, not_exist_goal)
          expect(response.status).to eq 302  
        end
        it "doesn't destroy goal" do
          expect do
            delete user_goal_path(sally, not_exist_goal)
          end.not_to change(Goal, :count)
        end
        it "redirects to to root_path" do
          delete user_goal_path(sally, not_exist_goal)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified goal exists" do
        it "returns HTTP STATUS 302" do
          delete user_goal_path(sally, sally_goal)
          expect(response.status).to eq 302
        end
        it "destroys goal" do
          delete user_goal_path(sally, sally_goal)
          expect(Goal.find_by(id: sally_goal.id)).to be_nil
        end
        it "redirects to to user_goals_path" do
          delete user_goal_path(sally, sally_goal)
          expect(response).to redirect_to user_goals_path(sally)  
        end
      end
    end
  end
end
