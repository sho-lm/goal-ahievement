FactoryBot.define do
  factory :john, class: User do
    id { 1 }
    name { "john"}
    token { "john_token" }
    password { "aaaaaa" }
  end

  factory :sally, class: User do
    name { "sally" }
    password { "1234aA" }
    is_admin { false }
    is_private { false }
  end
  
  factory :tom, class: User do
    name { "tom" }
    password { "1234aA" }
    is_admin { false }
    is_private { false }
  end

end
