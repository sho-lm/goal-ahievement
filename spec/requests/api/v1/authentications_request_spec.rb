require 'rails_helper'
include SessionsHelper

RSpec.describe "Api::V1::Authentications", type: :request do
  let(:john) { create(:john) }
  
  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
    context "when id is worng" do
      let(:wrong_id) { {  id: nil, token: john.token } } 
      it "returns status 401" do
        post api_v1_auth_path, params: wrong_id
        expect(response.status).to eq 401
      end
      it "returns error message" do
        post api_v1_auth_path, params: wrong_id
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "can't authenticate" 
      end
    end
    context "when token is wrong" do
      let(:wrong_token) { {  id: john.id, token: nil } } 
      it "returns status 401" do
        post api_v1_auth_path, params: wrong_token
        expect(response.status).to eq 401  
      end
      it "return error message" do
        post api_v1_auth_path, params: wrong_token
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "can't authenticate" 
      end
    end
    context "when request params are valid" do
      let(:params) { {  id: john.id, token: john.token } } 
      it "return status 200" do
        post api_v1_auth_path, params: params
        expect(response.status).to eq 200  
      end
      it "returns user who have logged in" do
        post api_v1_auth_path, params: params
        res_json = JSON.parse(response.body)
        expect(res_json["id"]).to eq current_user.id
      end
    end
  end
end
