FactoryBot.define do
  amazon_shipment = FactoryBot.create(:amazon_shipment)
  factory :indaba_sku do
    sku { Faker::Alphanumeric.alphanumeric(number: 10) }
    amazon_shipment_id { amazon_shipment.id }
    quantity { 1 }
  end
end
