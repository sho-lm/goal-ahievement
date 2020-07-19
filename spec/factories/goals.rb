FactoryBot.define do
  factory :test_goal, class: Goal do
    association :user, factory: :sally
    content { "test goal" }
  end
  
  factory :english_goal, class: Goal do
    association :user, factory: :sally
    content { "study English" }
  end
  
  factory :math_goal, class: Goal do
    association :user, factory: :sally
    content { "study math" }
  end
end
