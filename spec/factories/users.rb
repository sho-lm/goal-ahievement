FactoryBot.define do
  factory :tom, class: User do
    name { "tom" }
    password { "1234aA" }
    is_admin { true }
    is_private { true }
  end
end
