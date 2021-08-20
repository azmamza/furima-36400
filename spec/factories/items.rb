FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    info { Faker::Lorem.sentence }           
    category { Category.find(2) }
    status { Status.find(2) }
    shipping_fee { ShippingFee.find(2) }
    prefecture { Prefecture.find(2) }
    scheduled_delivery { ScheduledDelivery.find(2) }
    price { Faker::Number.between(from: 300, to: 9999999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end