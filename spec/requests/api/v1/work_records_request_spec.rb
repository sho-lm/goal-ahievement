require 'rails_helper'

RSpec.describe "Api::V1::WorkRecords", type: :request do
  let(:sally) { create(:sally) }
  let(:sally_work_record) { sally.work_records.create( worked_on: "2020-7-7") }
  let(:sally_login_params) { { name: sally.name, password: sally.password } }
  
  # index -----------------------------------------------------------------------------------------
  describe "GET #index" do
    context "when haven't logged in" do
      it "returns status 401" do
        get api_v1_user_work_records_path(sally)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          get api_v1_user_work_records_path(tom)
          expect(response.status).to eq 403
        end
        it "returns error message" do
          get api_v1_user_work_records_path(tom)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"
        end
      end
      context "when specified user is current_user" do
        it "returns status 200" do
          get api_v1_user_work_records_path(sally)
          expect(response.status).to eq 200  
        end
      end
      context "when date param is null" do
        it "returns work_record list where worked_on is today" do
          sally.work_records.create( worked_on: Date.today)
          get api_v1_user_work_records_path(sally)
          res_json = JSON.parse(response.body)
          expect(res_json[0]["worked_on"]).to eq Date.today.to_s
        end
      end
      context "when date params is specified" do
        it "returns work_record list where worked_on is specified date" do
          sally.work_records.create( worked_on: "2020-08-08")
          get api_v1_user_work_records_path(sally), params: { date: "2020-08-08" }
          res_json = JSON.parse(response.body)
          expect(res_json[0]["worked_on"]).to eq "2020-08-08"
        end
      end
    end
  end
  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
    context "when haven't logged in" do
      it "returns status 401" do
        post api_v1_user_work_records_path(sally)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          post api_v1_user_work_records_path(tom)
          expect(response.status).to eq 403
        end
        it "returns error message" do
          post api_v1_user_work_records_path(tom)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { work_record: { worked_on: nil } } }
        it "returns status 400" do
          post api_v1_user_work_records_path(sally), params: invalid_params
          expect(response.status).to eq 400  
        end
        it "returns error message" do
          post api_v1_user_work_records_path(sally), params: invalid_params
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "invalid params"
        end
        it "doesn't create new work_record" do
          expect do
            post api_v1_user_work_records_path(sally), params: invalid_params
          end.not_to change(WorkRecord, :count)
        end
      end
      context "when request params are valid" do
        let(:work_record_params) { { work_record: { worked_on: "2020-8-8" } }  }
        it "returns status 201" do
          post api_v1_user_work_records_path(sally), params: work_record_params
          expect(response.status).to eq 201  
        end
        it "returns created work_record" do
          post api_v1_user_work_records_path(sally), params: work_record_params
          res_json = JSON.parse(response.body)
          expect(res_json["worked_on"]).to eq "2020-08-08"  
        end
        it "creates new work_record" do
          expect do
            post api_v1_user_work_records_path(sally), params: work_record_params
          end.to change(WorkRecord, :count).by(1)
        end
      end
    end
  end
  # update ----------------------------------------------------------------------------------------
  describe "PATCH #update" do
    context "when haven't logged in" do
      it "returns status 401" do
        patch api_v1_user_work_record_path(sally, sally_work_record)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          patch api_v1_user_work_record_path(tom, sally_work_record)
          expect(response.status).to eq 403 
        end
        it "returns error message" do
          patch api_v1_user_work_record_path(tom, sally_work_record)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"  
        end
      end
      context "when specified user doesn't own specified work_record" do
        let(:tom) { create(:tom) }
        let(:tom_work_record) { tom.work_records.create(worked_on: "2020-8-8") }
        it "returns status 404" do
          patch api_v1_user_work_record_path(sally, tom_work_record)
          expect(response.status).to eq 404  
        end
        it "returns error message" do
          patch api_v1_user_work_record_path(sally, tom_work_record)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "work_record not found"  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { work_record: { worked_on: nil, memo: "updated" } } }
        it "returns status 400" do
          patch api_v1_user_work_record_path(sally, sally_work_record), params: invalid_params
          expect(response.status).to eq 400  
        end
        it "returns error message" do
          patch api_v1_user_work_record_path(sally, sally_work_record), params: invalid_params
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "invalid params"
        end
        it "doesn't update work_record" do
          expect do
            patch api_v1_user_work_record_path(sally, sally_work_record), params: invalid_params
          end.not_to change{ sally_work_record.reload.memo }
        end
      end
      context "when request params are valid" do
        let(:update_params) { { work_record: { worked_on: "2020-8-8", memo: "updated" } }  }
        it "returns status 200" do
          patch api_v1_user_work_record_path(sally, sally_work_record), params: update_params
          expect(response.status).to eq 200  
        end
        it "returns updated work_record" do
          patch api_v1_user_work_record_path(sally, sally_work_record), params: update_params
          res_json = JSON.parse(response.body)
          expect(res_json["memo"]).to eq "updated"
        end
        it "updates work_record" do
          expect do
            patch api_v1_user_work_record_path(sally, sally_work_record), params: update_params
          end.to change{ sally_work_record.reload.memo }.from(nil).to("updated")
        end
      end
    end
  end
  # destroy ---------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when haven't logged in" do
      it "returns status 401" do
        delete api_v1_user_work_record_path(sally, sally_work_record)
        expect(response.status).to eq 401
      end
    end
    context "when have logged in" do
      before do
        post api_v1_login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns status 403" do
          delete api_v1_user_work_record_path(tom, sally_work_record)
          expect(response.status).to eq 403
        end
        it "returns error message" do
          delete api_v1_user_work_record_path(tom, sally_work_record)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "not correct user"
        end
      end
      context "when specified user doesn't own specified work_record" do
        let(:tom) { create(:tom) }
        let(:tom_work_record) { tom.work_records.create(worked_on: "2020-8-8") }
        it "returns status 404" do
          delete api_v1_user_work_record_path(sally, tom_work_record)
          expect(response.status).to eq 404  
        end
        it "returns error message" do
          delete api_v1_user_work_record_path(sally, tom_work_record)
          res_json = JSON.parse(response.body)
          expect(res_json["error"]).to eq "work_record not found"
        end
        it "doesn't destroy work_record" do
          delete api_v1_user_work_record_path(sally, tom_work_record)
          expect(WorkRecord.find_by(id: tom_work_record.id)).not_to be_nil  
        end
      end
      context "when specified user owns specified work_record" do
        it "returns status 200" do
          delete api_v1_user_work_record_path(sally, sally_work_record)
          expect(response.status).to eq 200
        end
        it "destroys work_record" do
          delete api_v1_user_work_record_path(sally, sally_work_record)
          expect(WorkRecord.find_by(id: sally_work_record.id)).to be_nil 
        end
      end
    end
  end
end
