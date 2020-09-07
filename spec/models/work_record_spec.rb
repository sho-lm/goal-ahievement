require 'rails_helper'

RSpec.describe WorkRecord, type: :model do
  let(:sally) { create(:sally) }
  let(:sally_work_record) { sally.work_records.create( worked_on: "2020-7-7") }

  # validates ------------------------------------------------------------------------------------------------
  describe "validates" do
    context "with correct attributes" do
      it "is valid" do
        expect(sally_work_record).to be_valid  
      end
    end
    # worked_on ------------------------------------
    context "when worked_on is blank" do
      it "is invalid" do
        sally_work_record.worked_on = nil
        expect(sally_work_record).not_to be_valid  
      end
    end
    # worked_for -----------------------------------
    context "when worked_for is in 0..1440" do
      it "is valid" do
        sally_work_record.worked_for = 0
        expect(sally_work_record).to be_valid  
        sally_work_record.worked_for = 50
        expect(sally_work_record).to be_valid  
        sally_work_record.worked_for = 1440
        expect(sally_work_record).to be_valid  
      end
    end
    context "when worked_for is out of 0..1440" do
      it "is invalid" do
        sally_work_record.worked_for = -1
        expect(sally_work_record).not_to be_valid  
        sally_work_record.worked_for = 1441
        expect(sally_work_record).not_to be_valid  
      end
    end
    # user_id --------------------------------------
    context "when user_id is blank" do
      it "is invalid" do
        sally_work_record.user_id = nil
        expect(sally_work_record).not_to be_valid  
      end
    end
  end
  # methods -----------------------------------------------------------------------------------------------
end
