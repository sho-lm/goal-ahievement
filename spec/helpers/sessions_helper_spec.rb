require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:sally) { create(:sally) }
  # log_in --------------------------------------------------------------------------------------
  describe "#log_in" do
    it "preserves user in session" do
      log_in(sally)
      expect(session[:user_id]).to eq sally.id
    end
  end
  # current_user --------------------------------------------------------------------------------
  describe "#current_user" do
    context "when user have loged in" do
      it "returns session user" do
        log_in(sally)
        expect(current_user).to eq sally
      end
    end
    context "when user haven't loged in" do
      it "returns nil" do
        expect(current_user).to be_nil  
      end
    end
  end
  # current_user? ----------------------------------------------------------------------------------
  describe "#current_user?" do
    let(:sally) { create(:sally) }
    context "when specified user equals to current user" do
      it "returns true" do
        log_in(sally)
        expect(current_user?(sally)).to eq true  
      end
    end
    context "when specified user doesn't equal to current user" do
      it "returns false" do
        log_in(sally)
        not_sally = User.new(name: "user", id: 0)
        expect(current_user?(not_sally)).to eq false  
      end
    end
    
  end
  # logged_in? ------------------------------------------------------------------------------------
  describe "#logged_in?" do
    context "when user have logged in" do
      it "returns true" do
        sally = create(:sally)
        log_in(sally)
        expect(logged_in?).to eq true  
      end
    end
    context "when user haven't logged in" do
      it "returns false" do
        expect(logged_in?).to eq false
      end
    end
  end
  # log_out -------------------------------------------------------------------------------------
  describe "#log_out" do
    it "destroys session user" do
      log_in(sally)
      expect do
        log_out
      end.to change{ session[:user_id] }.from(sally.id).to(nil)
    end
  end
end
