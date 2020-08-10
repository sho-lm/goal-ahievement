require 'rails_helper'
include SessionsHelper

RSpec.describe "Api::V1::Sessions", type: :request do
  let(:john) { create(:john) }
  
  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
    context "when name is worng" do
      let(:wrong_name) { {  name: nil, password: john.password } } 
      it "returns status 401" do
        post api_v1_login_path, params: wrong_name
        expect(response.status).to eq 401  
      end
      it "return error message" do
        post api_v1_login_path, params: wrong_name
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "can't log in" 
      end
    end
    context "when password is wrong" do
      let(:wrong_password) { {  name: john.name, password: nil } } 
      it "returns status 401" do
        post api_v1_login_path, params: wrong_password
        expect(response.status).to eq 401  
      end
      it "return error message" do
        post api_v1_login_path, params: wrong_password
        res_json = JSON.parse(response.body)
        expect(res_json["error"]).to eq "can't log in" 
      end
    end
    context "when request params are valid" do
      let(:params) { {  name: john.name, password: john.password } } 
      it "return status 200" do
        post api_v1_login_path, params: params
        expect(response.status).to eq 200  
      end
      it "returns user who have logged in" do
        post api_v1_login_path, params: params
        res_json = JSON.parse(response.body)
        expect(res_json["id"]).to eq current_user.id  
      end
    end
  end

  # destroy ---------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when user haven't logged in" do
      it "returns status 200" do
        delete api_v1_logout_path
        expect(response.status).to eq 200  
      end
    end
    context "when user haven logged in" do
      let(:params) { {  name: john.name, password: john.password } } 
      before do
        post api_v1_login_path, params: params
      end
      it "returns status 200" do
        delete api_v1_logout_path
        expect(response.status).to eq 200  
      end
      it "makes user log out" do
        delete api_v1_logout_path
        expect(logged_in?).to eq false  
      end
    end
    
  end
  
end
