FactoryBot.define do
  factory :test_goal, class: Goal do
    content { "test goal" }
  end

  factory :english_goal, class: Goal do
    content { "study English" }
  end

  factory :math_goal, class: Goal do
    content { "study math" }
  end
end
