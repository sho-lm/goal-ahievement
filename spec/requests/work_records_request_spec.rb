require 'rails_helper'

RSpec.describe "WorkRecords", type: :request do
  let(:sally) { create(:sally) }
  let(:sally_work_record) { sally.work_records.create(content: "sally work record", worked_on: "2020-7-7") }
  let(:sally_login_params) { { session: { account_id: sally.account_id, password: sally.password } } }
  # index -----------------------------------------------------------------------------------------
  describe "GET #index" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get user_work_records_path(sally)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get user_work_records_path(sally)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get user_work_records_path(tom)
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
          get user_work_records_path(tom)
          expect(response).to redirect_to root_path
        end
      end
      context "when specified user is current_user" do
        it "returns HTTP STATUS 200" do
          get user_work_records_path(sally)
          expect(response.status).to eq 200
        end
        it "shows work record list" do
          sally.work_records.create(content: "sally work record!!", worked_on: "2020-7-7")
          get user_work_records_path(sally)
          expect(response.body).to include "sally work record!!"
        end
      end
    end
  end
  # new -------------------------------------------------------------------------------------------
  describe "GET #new" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get new_user_work_record_path(sally)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get new_user_work_record_path(sally)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get new_user_work_record_path(tom)
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
          get new_user_work_record_path(tom)
          expect(response).to redirect_to root_path
        end
      end
      context "when specified user is current_user" do
        it "returns HTTP STATUS 200" do
          get new_user_work_record_path(sally)
          expect(response.status).to eq 200  
        end
      end
    end
  end
  # show ------------------------------------------------------------------------------------------
  describe "GET #show" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get user_work_record_path(sally, sally_work_record)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get user_work_record_path(sally, sally_work_record)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          get user_work_record_path(tom, sally_work_record)
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
          get user_work_record_path(tom, sally_work_record)
          expect(response).to redirect_to root_path
        end
      end
      context "when specified work_record doesn't exist" do
        let(:not_exist_work_record) { sally.work_records.build(id: -1, content: "not exist work record", worked_on: "2020-7-7") }
        it "return HTTP STATUS 302" do
          get user_work_record_path(sally, not_exist_work_record)
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          get user_work_record_path(sally, not_exist_work_record)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified work record exists" do
        it "returns HTTP STATUS 200" do
          get user_work_record_path(sally, sally_work_record)
          expect(response.status).to eq 200
        end
        it "shows work record content" do
          get user_work_record_path(sally, sally_work_record)
          expect(response.body).to include "sally work record"
        end
      end
    end
  end
  # edit ------------------------------------------------------------------------------------------
  describe "GET #edit" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        get edit_user_work_record_path(sally, sally_work_record)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        get edit_user_work_record_path(sally, sally_work_record)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
        get edit_user_work_record_path(tom, sally_work_record)
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
        get edit_user_work_record_path(tom, sally_work_record)
          expect(response).to redirect_to root_path
        end
      end
      context "when specified work_record doesn't exist" do
        let(:not_exist_work_record) { sally.work_records.build(id: -1, content: "not exist work record", worked_on: "2020-7-7") }
        it "return HTTP STATUS 302" do
          get edit_user_work_record_path(sally, not_exist_work_record)
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          get edit_user_work_record_path(sally, not_exist_work_record)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified work_record exists" do
        it "returns HTTP STATUS 200" do
          get edit_user_work_record_path(sally, sally_work_record)
          expect(response.status).to eq 200
        end
        it "shows work_record content" do
          get edit_user_work_record_path(sally, sally_work_record)
          expect(response.body).to include "sally work record"
        end
      end
    end
  end
  # create ----------------------------------------------------------------------------------------
  describe "POST #create" do
    let(:work_record_params) { { work_record: { content: "work record", worked_on: "2020-7-7" } } }
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        post user_work_records_path(sally), params: work_record_params
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        post user_work_records_path(sally), params: work_record_params
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
        post user_work_records_path(tom), params: work_record_params
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
        post user_work_records_path(tom), params: work_record_params
          expect(response).to redirect_to root_path
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { work_record: { content: nil } } }
        it "return HTTP STATUS 200" do
          post user_work_records_path(sally), params: invalid_params
          expect(response.status).to eq 200  
        end
        it "doesn't create work_record" do
          expect do
            post user_work_records_path(sally), params: invalid_params
          end.not_to change(WorkRecord, :count)
        end
        it "shows error message" do
          post user_work_records_path(sally), params: invalid_params
          expect(response.body).to include ERB::Util.h("Content can't be blank")
        end
      end
      context "when request params are valid" do
        it "returns HTTP STATUS 302" do
          post user_work_records_path(sally), params: work_record_params
          expect(response.status).to eq 302  
        end
        it "creates work_record" do
          expect do
            post user_work_records_path(sally), params: work_record_params
          end.to change(WorkRecord, :count).by(1)
        end
        it "redirects to to user_work_records_path" do
          post user_work_records_path(sally), params: work_record_params
          expect(response).to redirect_to user_work_records_path(sally)  
        end
      end
    end
  end
  # update ----------------------------------------------------------------------------------------
  describe "PUT #update" do
  let(:updated_params) { { work_record: { content: "updated", worked_on: "2020-7-7" } }  }
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        put user_work_record_path(sally, sally_work_record), params: updated_params
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        put user_work_record_path(sally, sally_work_record), params: updated_params
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
        put user_work_record_path(tom, sally_work_record), params: updated_params
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
        put user_work_record_path(tom, sally_work_record), params: updated_params
          expect(response).to redirect_to root_path
        end
      end
      context "when specified work_record doesn't exist" do
        let(:not_exist_work_record) { sally.work_records.build(id: -1, content: "not exist work record", worked_on: "2020-7-7") }
        it "return HTTP STATUS 302" do
          put user_work_record_path(sally, not_exist_work_record), params: updated_params
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          put user_work_record_path(sally, not_exist_work_record), params: updated_params
          expect(response).to redirect_to root_path  
        end
      end
      context "when request params are invalid" do
        let(:invalid_params) { { work_record: { content: nil } } }
        it "return HTTP STATUS 200" do
          put user_work_record_path(sally, sally_work_record), params: invalid_params
          expect(response.status).to eq 200  
        end
        it "doesn't update work_record" do
          expect do
          put user_work_record_path(sally, sally_work_record), params: invalid_params
          end.not_to change{ sally_work_record.reload.content }
        end
        it "shows error message" do
          put user_work_record_path(sally, sally_work_record), params: invalid_params
          expect(response.body).to include ERB::Util.h("Content can't be blank")
        end
      end
      context "when request params are valid" do
        it "returns HTTP STATUS 302" do
          put user_work_record_path(sally, sally_work_record), params: updated_params
          expect(response.status).to eq 302  
        end
        it "updates work record content" do
          expect do
          put user_work_record_path(sally, sally_work_record), params: updated_params
          end.to change { sally_work_record.reload.content }.from("sally work record").to("updated")
        end
        it "redirects to user_work_records_path" do
          put user_work_record_path(sally, sally_work_record), params: updated_params
          expect(response).to redirect_to user_work_records_path(sally)
        end
      end
    end
  end
  # destroy ---------------------------------------------------------------------------------------
  describe "DELETE #destroy" do
    context "when haven't logged in" do
      it "returns HTTP STATUS 302" do
        delete user_work_record_path(sally, sally_work_record)
        expect(response.status).to eq 302
      end
      it "redirects to login_path" do
        delete user_work_record_path(sally, sally_work_record)
        expect(response).to redirect_to login_path  
      end
    end
    context "when have logged in" do
      before do
        post login_path, params: sally_login_params
      end
      context "when specified user isn't current_user" do
        let(:tom) { create(:tom) }
        it "returns HTTP STATUS 302" do
          delete user_work_record_path(tom, sally_work_record)
          expect(response.status).to eq 302
        end
        it "redirects to root_path" do
          delete user_work_record_path(tom, sally_work_record)
          expect(response).to redirect_to root_path
        end
      end
      context "when specified work_record doesn't exist" do
        let(:not_exist_work_record) { sally.work_records.build(id: -1, content: "not exist work record", worked_on: "2020-7-7") }
        it "return HTTP STATUS 302" do
          delete user_work_record_path(sally, not_exist_work_record)
          expect(response.status).to eq 302  
        end
        it "redirects to to root_path" do
          delete user_work_record_path(sally, not_exist_work_record)
          expect(response).to redirect_to root_path  
        end
      end
      context "when specified work record exists" do
        it "returns HTTP STATUS 302" do
          delete user_work_record_path(sally, sally_work_record)
          expect(response.status).to eq 302
        end
        it "destroys work record" do
          delete user_work_record_path(sally, sally_work_record)
          expect(WorkRecord.find_by(id: sally_work_record.id)).to be_nil
        end
        it "redirects to to user_work_records_path" do
          delete user_work_record_path(sally, sally_work_record)
          expect(response).to redirect_to user_work_records_path(sally)
        end
      end
    end
  end
end
