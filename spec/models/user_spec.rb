require 'rails_helper'

RSpec.describe User, type: :model do
  # default -----------------------------------------------------------------------------------------------------
  describe "#default" do
    context "when #new without arguments" do
      let(:no_args_user) { User.new }
      it "is_admin has default value" do
        expect(no_args_user.is_admin).to eq false
      end
      it "is_private has default value" do
        expect(no_args_user.is_private).to eq false
      end
    end
    context "when #new with is_admin" do
      it "is_admin has specified value" do
        user = User.new(is_admin: true)
        expect(user.is_admin).to eq true
      end
    end
    context "when #new with is_private" do
      it "is_private has specified value" do
        user = User.new(is_private: true)
        expect(user.is_private).to eq true
      end
    end
  end
  # validates ------------------------------------------------------------------------------------------------
  describe "#validate" do
    let(:sally) { build(:sally) }
    context "with correct attributes" do
      it "is valid" do
        expect(sally).to be_valid  
      end
    end
    # name  ------------------------------------------
    context "when name is blank" do
      it "is invalid" do
        sally.name = nil
        expect(sally).not_to be_valid
      end
    end
    context "when name lenght is less than or equal to 20" do
      it "is valid" do
        sally.name = "a" * 20
        expect(sally).to be_valid  
      end
    end
    context "when name lenght is greater than 20" do
      it "is invalid" do
        sally.name = "a" * 21
        expect(sally).not_to be_valid  
      end
    end
    # password  ---------------------------------------
    context "when password is blank" do
      it "is invalid" do
        sally.password = nil
        expect(sally).not_to be_valid
      end
    end
    context "when password length is between 6 and 20" do
      it "is valid" do
        sally.password = "a" * 6
        expect(sally).to be_valid
        sally.password = "a" * 20
        expect(sally).to be_valid      
      end
    end
    context "when password length is less than 6" do
      it "is invalid" do
        sally.password = "a" * 5
        expect(sally).not_to be_valid  
      end
    end
    context "when password lenght is greater than 20" do
      it "is invalid" do
        sally.password = "a" * 21
        expect(sally).not_to be_valid          
      end
    end
    # is_admin ------------------------------------------------------------------------------------
    context "when is_admin is blank" do
      it "is invalid" do
        sally.is_admin = nil
        expect(sally).not_to be_valid
      end
    end
    # is_private -------------------------------------------------------------------------------
    context "when is_private is blank" do
      it "is invalid" do
        sally.is_private = nil
        expect(sally).not_to be_valid
      end
    end
  end
end
