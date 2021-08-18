class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i } do
    validates :password
    validates :password_confirmation
  end

  # has_many :items
  # has_many :orders
end
