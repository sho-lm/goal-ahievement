require 'rails_helper'

RSpec.describe "Users", type: :request do
  # show -----------------------------------------------------------------------------------------------------
  describe "GET #show" do
    let(:sally) { create(:sally) }
    context "when not logged in" do
      it "returns HTTP STATUS 302" do
      end
      it "redirects login_path" do
        
      end
    end
    context "when specified user exists" do
      it "returns HTTP STATUS 200" do
        get user_path sally
        expect(response.status).to eq 200  
      end
      it "shows user name" do
        get user_path sally
        expect(response.body).to include "sally"  
      end
    end
    context "when specified user doesn't exist" do
      let(:not_exist_user) { User.new(name: "name", id: 0) }
      it "returns HTTP STATUS 302" do
        get user_path not_exist_user
        expect(response.status).to eq 302  
      end
      it "redirects goals_path" do
        get user_path not_exist_user
        expect(response).to redirect_to goals_path  
      end
    end
    
  end
  describe "GET #new" do
    it "return HTTP STATUS 200" do
      get new_user_path
      expect(response.status).to eq 200  
    end
  end
  describe "GET #edit" do
    context "when not logged in" do
      it "returns HTTP STATUS 302" do
      end
      it "redirects login_path" do
        
      end
    end
    context "when specified user exists" do
      let(:sally) { create(:sally) }
      it "return HTTP STATUS 200" do
        get edit_user_path sally.id
        expect(response.status).to eq 200  
      end
      it "shows user name" do
        get edit_user_path sally.id
        expect(response.body).to include "sally"
      end
    end
    context "when specified user doesn't exist" do
      let(:not_exist_user) { User.new(name: "name",  id: 0) }
      it "returns HTTP STATUS 302" do
        get edit_user_path not_exist_user.id
        expect(response.status).to eq 302
      end
      it "redirects goals_path" do
        get edit_user_path not_exist_user.id
        expect(response).to redirect_to goals_path
      end
    end
    
  end
  describe "POST #create" do
    context "with valid params" do
      let(:sally) { build(:sally) }
      it "returns HTTP STATUS 302" do
        post users_path, params: { user: attributes_for(:sally) }
        expect(response.status).to eq 302  
      end
      it "creates new User" do
        expect do
          post users_path, params: { user: attributes_for(:sally) }
        end.to change(User, :count).by(1)
      end
    end
    context "with invalid params" do
      let(:params_invalid) { { user: { name: nil } }}
      it "returns HTTP STATUS 200" do
        post users_path, params: params_invalid
        expect(response.status).to eq 200  
      end
      it "doesn't create new User" do
        expect do
          post users_path, params: params_invalid
        end.not_to change(User, :count)
      end
      it "shows error message" do
        post users_path, params: params_invalid
        expect(response.body).to include ERB::Util.h("Name can't be blank")
      end
    end
  end
  describe "PUT #update" do
    let(:sally) { create(:sally) }
    context "with valid params" do
      it "returns HTTP STATUS 302" do
        put user_path sally, params: { user: attributes_for(:tom) }
        expect(response.status).to eq 302  
      end
      it "updates user name" do
        expect do
          put user_path sally, params: { user: attributes_for(:tom) }
        end.to change{User.find(sally.id).name }.from("sally").to("tom")
      end
      it "redirects user_path" do
        put user_path sally, params: { user: attributes_for(:tom) }
        expect(response).to redirect_to user_path sally.id  
      end
    end
    context "with invalid params" do
      let(:params_invalid) { { user: { name: nil } } }
      it "returns HTTP STATUS 200" do
        put user_path sally, params: params_invalid
        expect(response.status).to eq 200  
      end
      it "doesn't update user name" do
        expect do
          put user_path sally, params: params_invalid
        end.not_to change{ User.find(sally.id).name }
      end
      it "shows error message" do
        put user_path sally, params: params_invalid
        expect(response.body).to include ERB::Util.h("Name can't be blank")  
      end
    end
    context "when specified user doesn't exist" do
      let(:not_exist_user) { User.new(name: "name", id: 0) }
      it "returns HTTP STATUS 302" do
        put user_path not_exist_user, params: {}
        expect(response.status).to eq 302
      end
      it "redirects goals_path" do
        put user_path not_exist_user, params: {}
        expect(response).to redirect_to goals_path  
      end
    end
  end
  describe "DELETE #destroy" do
    context "when specified user exists" do
      let(:sally) { create(:sally) }
      it "returns HTTP STATUS 302" do
        delete user_path sally
        expect(response.status).to eq 302
      end
      it "destroys user" do
        delete user_path sally
        expect(User.find_by(id: sally.id)).to be_nil
      end
      it "redirects goals_path" do
        delete user_path sally
        expect(response).to redirect_to goals_path  
      end
    end
    context "when specified user doesn't exist" do
      let(:not_exist_user) { User.new(name: "not exists", id: 0) }
      it "returns HTTP STATUS 302" do
        delete user_path not_exist_user
        expect(response.status).to eq 302  
      end
      it "doesn't destroy user" do
        expect do
          delete user_path not_exist_user
        end.not_to change(User, :count)  
      end
      it "redirects goals_path" do
        delete user_path not_exist_user
        expect(response).to redirect_to goals_path  
      end
    end
  end
end
