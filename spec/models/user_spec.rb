require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#default" do
    # new without arguments ------------------------------------------------------------------------
    context "when #new without arguments" do
      let(:no_args_user) { User.new }
      it "is_admin has default value" do
        expect(no_args_user.is_admin).to eq false
      end
      it "is_private has default value" do
        expect(no_args_user.is_private).to eq false
      end
    end
    # new with arguments -----------------------------------------------------------------------
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
  describe "#validate" do
    let(:tom) { build(:tom) }
    # valid -----------------------------------------------------------------------------------
    context "with name, password, is_admin, is_private" do
      it "is valid" do
        expect(tom).to be_valid  
      end
    end
    # invalid ---------------------------------------------------------------------------------
    # name ------------------------------------------------------------------------------------
    context "without name" do
      it "is invalid" do
        tom.name = nil
        expect(tom).not_to be_valid
      end
    end
    context "when name lenght is less than or equal to 50" do
      it "is valid" do
        tom.name = "a" * 50
        expect(tom).to be_valid  
      end
    end
    context "when name lenght is greater than 50" do
      it "is invalid" do
        tom.name = "a" * 51
        expect(tom).not_to be_valid  
      end
    end
    # password ---------------------------------------------------------------------------------
    context "without password" do
      it "is invalid" do
        tom.password = nil
        expect(tom).not_to be_valid
      end
    end
    context "when password length is less than 6" do
      it "is invalid" do
        tom.password = "123aA"
        expect(tom).not_to be_valid  
      end
    end
    context "when password lenght is greater than 20" do
      it "is invalid" do
        tom.password = "1" * 19 + "aA"
        expect(tom).not_to be_valid          
      end
    end
    # is_admin ------------------------------------------------------------------------------------
    context "without is_admin" do
      it "is invalid" do
        tom.is_admin = nil
        expect(tom).not_to be_valid
      end
    end
    # is_private -------------------------------------------------------------------------------
    context "without is_private" do
      it "is invalid" do
        tom.is_private = nil
        expect(tom).not_to be_valid
      end
    end
  end
  
end
