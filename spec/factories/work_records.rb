FactoryBot.define do
  factory :test_work_record, class: WorkRecord do
    association :user, factory: :sally
    worked_on { "2020-7-20" }
  end
end
