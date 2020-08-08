require 'rails_helper'
include SessionsHelper

RSpec.describe "Api::V1::Users", type: :request do
  let(:sally) { create(:sally) }
  let(:sally_login_params) { { account_id: sally.account_id, password: sally.password } }
  
  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
    context "when request params are invalid" do
      let(:invalid_params) { { user: { name: nil } }}
      it "returns status 400" do
        post api_v1_users_path, params: invalid_params
        expect(response.status).to eq 400  
      end
      it "returns error message" do
        post api_v1_users_path, params: invalid_params
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "invalid params" 
      end
      it "doesn't create new user" do
        expect do
          post api_v1_users_path, params: invalid_params
        end.not_to change(User, :count)
      end
    end
    context "when request params are valid" do
      let(:params) { { user: { account_id: "test", name: "test", password: "aaaaaa" } } }
      it "returns status 201" do
        post api_v1_users_path, params: params
        expect(response.status).to eq 201 
      end
      it "returns created user who have logged in" do
        post api_v1_users_path, params: params
        res_json = JSON.parse(response.body)
        expect(res_json["id"]).to eq current_user.id  
      end
      it "creates new user" do
        expect do
          post api_v1_users_path, params: params
        end.to change(User, :count).by(1)
      end
    end
  end

  # update ----------------------------------------------------------------------------------------
  describe "PATCH #update" do
    context "when haven't logged in" do
      it "returns status 401" do
        patch api_v1_user_path(sally)
        expect(response.status).to eq 401  
      end
      it "returns error message" do
        patch api_v1_user_path(sally)
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "need log in"
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          patch api_v1_user_path(tom)
          expect(response.status).to eq 403 
        end
        it "returns error message" do
          patch api_v1_user_path(tom)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { user: { name: nil } } }
        it "returns status 400" do
          patch api_v1_user_path(sally), params: invalid_params
          expect(response.status).to eq 400  
        end
        it "returns error message" do
          patch api_v1_user_path(sally), params: invalid_params
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "invalid params"
        end
        it "doesn't update user" do
          expect do
            patch api_v1_user_path(sally), params: invalid_params
          end.not_to change{ sally.reload.name }
        end
      end
      context "when request params are valid" do
      let(:update_params) { { user: { name: "updated" } }  }
        it "returns status 200" do
          patch api_v1_user_path(sally), params: update_params
          expect(response.status).to eq 200  
        end
        it "returns updated user" do
          patch api_v1_user_path(sally), params: update_params
          res_json = JSON.parse(response.body)
          expect(res_json["name"]).to eq "updated"  
        end
        it "updates user" do
          expect do
            patch api_v1_user_path(sally), params: update_params
          end.to change{ sally.reload.name }.from("sally").to("updated")
        end
      end
    end
  end
  # destroy ---------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when haven't logged in" do
      it "returns status 401" do
        delete api_v1_user_path(sally)
        expect(response.status).to eq 401  
      end
      it "returns error message" do
        delete api_v1_user_path(sally)
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "need log in"
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't' current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          delete api_v1_user_path(tom)
          expect(response.status).to eq 403  
        end
        it "returns error message" do
          delete api_v1_user_path(tom)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
        it "doesn't destroy user" do
          delete api_v1_user_path(tom)
          expect(User.find_by(id: tom.id)).not_to be_nil  
        end
      end
      context "when specified user is current_user" do
        it "returns status 200" do
          delete api_v1_user_path(sally)
          expect(response.status).to eq 200
        end
        it "destroys user" do
          delete api_v1_user_path(sally)
          expect(User.find_by(id: sally.id)).to be_nil  
        end
        it "makes user log out" do
          delete api_v1_user_path(sally)
          expect(logged_in?).to eq false 
        end
      end
    end
  end
end
