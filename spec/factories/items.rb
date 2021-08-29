FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    info { Faker::Lorem.sentence }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
