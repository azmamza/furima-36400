class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :info
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1, message: "can't be blank"}  do
    validates :category
    validates :status
    validates :shipping_fee
    validates :prefecture
    validates :scheduled_delivery
  end

  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end