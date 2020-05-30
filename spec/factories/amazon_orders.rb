FactoryBot.define do
  factory :amazon_order do
    order_total { 100.00 }
    purchase_date { Time.now - 3.days }
    status { 'done' }
  end
end