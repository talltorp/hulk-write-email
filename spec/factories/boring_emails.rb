FactoryBot.define do
  factory :boring_email do
    email { "MyString" }
    subject { "MyString" }
    body { "MyText" }
    summary { "MyText" }
  end
end
