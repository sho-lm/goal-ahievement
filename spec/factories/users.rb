FactoryBot.define do
  factory :sally, class: User do
    name { "sally" }
    password { "1234aA" }
    is_admin { false }
    is_private { false }
  end
  
  factory :tom, class: User do
    name { "tom" }
    password { "1234aA" }
    is_admin { true }
    is_private { true }
  end
end
