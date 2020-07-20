require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  # new -----------------------------------------------------------------------------------------
  describe "GET #new" do
    it "returns HTTP STATUS 200" do
      get login_path
      expect(response.status).to eq 200
    end
  end
  # create ---------------------------------------------------------------------------------------
  let(:sally) { create(:sally) }
  describe "POST #create" do
    context "when specified user account_id is wrong" do
      let(:wrong_account_id_params) { { session: { account_id: "not sally id", password: sally.password } } }
      it "returns HTTP STATUS 200" do
        post login_path, params: wrong_account_id_params
        expect(response.status).to eq 200  
      end
      it "doesn't preserve user in session" do
        post login_path, params: wrong_account_id_params
        expect(session[:user_id]).to be_nil
      end
    end
    context "when specified user password is wrong" do
      let(:wrong_password_params) { { session: { account_id: sally.account_id, password: "not sally password"} } }
      it "returns HTTP STATUS 200" do
        post login_path, params: wrong_password_params
        expect(response.status).to eq 200  
      end
      it "doesn't preserve user in session" do
        post login_path, params: wrong_password_params
        expect(session[:user_id]).to be_nil
      end
    end
    context "when specified user is authenticated" do
      let(:sally_login_params) { { session: { account_id: sally.account_id, password: sally.password } } }
      it "returns HTTP STATS 302" do
        post login_path, params: sally_login_params
        expect(response.status).to eq 302  
      end
      it "preserves user in session" do
        post login_path, params: sally_login_params
        expect(session[:user_id]).to eq sally.id
      end
      it "redirects root_path" do
        post login_path, params: sally_login_params
        expect(response).to redirect_to root_path  
      end
    end
  end
  # destroy --------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    let(:sally_login_params) { { session: { account_id: sally.account_id, password: sally.password } } }
    before do
      post login_path, params: sally_login_params
    end
    it "returns HTTP STATUS 302" do
      delete logout_path
      expect(response.status).to eq 302  
    end
    it "redirects root_path" do
      delete logout_path
      expect(response).to redirect_to root_path
    end
    it "destroys session user" do
      expect do
        delete logout_path
      end.to change{ session[:user_id] }.from(sally.id).to(nil)
    end
  end
end
