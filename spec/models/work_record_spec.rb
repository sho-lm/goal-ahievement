require 'rails_helper'

RSpec.describe WorkRecord, type: :model do
  # validates ------------------------------------------------------------------------------------------------
  describe "validates" do
    let(:test_work_record) { create(:test_work_record) }
    context "with correct attributes" do
      it "is valid" do
        expect(test_work_record).to be_valid  
      end
    end
    # content -------------------------------------
    context "when content is blank" do
      it "is invalid" do
        test_work_record.content = nil
        expect(test_work_record).not_to be_valid  
      end
    end
    # worked_on ------------------------------------
    context "when worked_on is blank" do
      it "is invalid" do
        test_work_record.worked_on = nil
        expect(test_work_record).not_to be_valid  
      end
    end
    # worked_for -----------------------------------
    context "when worked_for is in 0..1440" do
      it "is valid" do
        test_work_record.worked_for = 0
        expect(test_work_record).to be_valid  
        test_work_record.worked_for = 50
        expect(test_work_record).to be_valid  
        test_work_record.worked_for = 1440
        expect(test_work_record).to be_valid  
      end
    end
    context "when worked_for is out of 0..1440" do
      it "is invalid" do
        test_work_record.worked_for = -1
        expect(test_work_record).not_to be_valid  
        test_work_record.worked_for = 1441
        expect(test_work_record).not_to be_valid  
      end
    end
    # user_id --------------------------------------
    context "when user_id is blank" do
      it "is invalid" do
        test_work_record.user_id = nil
        expect(test_work_record).not_to be_valid  
      end
    end
  end
  # methods -----------------------------------------------------------------------------------------------
end
