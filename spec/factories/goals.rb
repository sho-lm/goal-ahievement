FactoryBot.define do
  factory :test_goal, class: Goal do
    association :user, factory: :sally
    content { "test goal" }
    color { "#00ff00ff" }
  end
end
