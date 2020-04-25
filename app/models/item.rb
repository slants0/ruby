class Item < ApplicationRecord
  belongs_to :seller
  belongs_to :payment_intent
  has_one :gift_card_detail
  has_one :donation_detail
  enum item_type: [:donation, :gift_card]
end
