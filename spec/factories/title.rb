FactoryBot.define do
  factory :title do
    title_number { Faker::Alphanumeric.alphanumeric(number: 10) }
    value { Faker::Number.decimal(l_digits: 5) }
    due_date { Faker::Date.between(from: Date.tomorrow, to: Date.tomorrow + 3.week) }
    cnpj_assignor { Faker::CNPJ.pretty }
    cnpj_drawee { Faker::CNPJ.pretty }
  end
end