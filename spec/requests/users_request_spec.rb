require 'rails_helper'
include SessionsHelper

RSpec.describe "Users", type: :request do
  let(:sally) { create(:sally) }
  let(:sally_params) { { session: { name: sally.name, password: sally.password } } }
  # new -------------------------------------------------------------------------------------------
  describe "GET #new" do
    it "returns HTTP STATUS 200" do
      get login_path
      expect(response.status).to eq 200 
    end
  end

  # show -----------------------------------------------------------------------------------------------------
  describe "GET #show" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get user_path sally
        expect(response.status).to eq 302
      end
      it "redirects login_path" do
        get user_path sally
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get user_path tom
          expect(response.status).to eq 302  
        end
        it "redirects root_path" do
          get user_path tom
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified user is current_user" do
        it "returns HTTP STATUS 200" do
          get user_path sally
          expect(response.status).to eq 200  
        end
        it "shows user name" do
          get user_path sally
          expect(response.body).to include "sally"  
        end
      end
    end
  end
  
  # edit ------------------------------------------------------------------------------------------
  describe "GET #edit" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get edit_user_path sally.id
        expect(response.status).to eq 302  
      end
      it "redirects login_path" do
        get edit_user_path sally.id
        expect(response).to redirect_to login_path
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_params
      end
      context "when specified user isn't current_user" do
        let(:not_exist_user) { User.new(name: "name",  id: 0) }
        it "returns HTTP STATUS 302" do
          get edit_user_path not_exist_user.id
          expect(response.status).to eq 302
        end
        it "redirects root_path" do
          get edit_user_path not_exist_user.id
          expect(response).to redirect_to root_path
        end
      end
      context "when specified user is current_user" do
        it "return HTTP STATUS 200" do
          get edit_user_path sally.id
          expect(response.status).to eq 200  
        end
        it "shows user name" do
          get edit_user_path sally.id
          expect(response.body).to include "sally"
        end
      end
    end
  end

  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
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
    context "with valid params" do
      let(:tom) { build(:tom) }
      it "returns HTTP STATUS 302" do
        post users_path, params: { user: attributes_for(:tom) }
        expect(response.status).to eq 302  
      end
      it "creates new User" do
        expect do
          post users_path, params: { user: attributes_for(:tom) }
        end.to change(User, :count).by(1)
      end
      it "logged in by created user" do
        post users_path, params: { user: attributes_for(:tom) }
        expect(current_user.name).to eq tom.name
      end
    end
  end

  # update ----------------------------------------------------------------------------------------
  describe "PUT #update" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        put user_path sally
        expect(response.status).to eq 302  
      end
      it "redirects login_path" do
        put user_path sally
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          put user_path tom, params: {}
          expect(response.status).to eq 302
        end
        it "redirects root_path" do
          put user_path tom, params: {}
          expect(response).to redirect_to root_path  
        end
      end
      context "with invalid params" do
        let(:invalid_params) { { user: { name: nil } } }
        it "returns HTTP STATUS 200" do
          put user_path sally, params: invalid_params
          expect(response.status).to eq 200  
        end
        it "doesn't update user name" do
          expect do
            put user_path sally, params: invalid_params
          end.not_to change{ User.find(sally.id).name }
        end
        it "shows error message" do
          put user_path sally, params: invalid_params
          expect(response.body).to include ERB::Util.h("Name can't be blank")  
        end
      end
      context "with valid params" do
        let(:valid_params) { { user: { name: "tom" } } }
        it "returns HTTP STATUS 302" do
          put user_path sally, params: valid_params
          expect(response.status).to eq 302  
        end
        it "updates user name" do
          expect do
            put user_path sally, params: valid_params
          end.to change{User.find(sally.id).name }.from("sally").to("tom")
        end
        it "redirects user_path" do
          put user_path sally, params: valid_params
          expect(response).to redirect_to user_path sally.id  
        end
      end
    end
  end

  # destroy ----------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        delete user_path sally
        expect(response.status).to eq 302
      end
      it "redirects login_path" do
        delete user_path sally
        expect(response.status).to redirect_to login_path
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_params
      end
      context "when specified user isn't' current_user" do
        let(:tom) { User.new(id: 0, name: "tom") }
        it "returns HTTP STATUS 302" do
          delete user_path tom
          expect(response.status).to eq 302  
        end
        it "doesn't destroy user" do
          expect do
            delete user_path tom
          end.not_to change(User, :count)  
        end
        it "redirects root_path" do
          delete user_path tom
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified user is current_user" do
        it "returns HTTP STATUS 302" do
          delete user_path sally
          expect(response.status).to eq 302
        end
        it "destroys user" do
          delete user_path sally
          expect(User.find_by(id: sally.id)).to be_nil
        end
        it "redirects root_path" do
          delete user_path sally
          expect(response).to redirect_to root_path  
        end
      end
    end
  end
end
