require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入機能の実装' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '購入ができる場合' do
      it '全ての情報が存在すれば出品できること' do
        expect(@order_address).to be_valid
      end

      it '建物名は空でも購入できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end

    end


    context '購入ができない場合' do

      it '郵便番号が空では購入できないこと' do
        @order_address.postal_code  = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」以外では購入できないこと' do
        @order_address.postal_code  = 1234-567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '郵便番号がハイフンなしでは購入できないこと' do
        @order_address.postal_code  = 1234567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '郵便番号が半角数値でなければ出品できないこと' do
        @order_address.postal_code  = '１２３−４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '郵便番号が英数字混合では購入できないこと' do
        @order_address.postal_code  = 'abc-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '郵便番号が半角英字では購入できないこと' do
        @order_address.postal_code  = 'abc-defg'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '都道府県のidが１の選択肢を選択すると出品できないこと' do
        @order_address.prefecture_id  = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できないこと' do
        @order_address.city  = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できないこと' do
        @order_address.address  = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できないこと' do
        @order_address.phone_number  = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end 

      it '電話番号が９桁以下では購入できないこと' do
        @order_address.phone_number  = 012012345
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include ("Phone number is invalid")
      end

      it '電話番号が１２桁以下では購入できないこと' do
        @order_address.phone_number  = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include ("Phone number is invalid")
      end

      it '電話番号がハイフンを含む場合は出品できないこと' do
        @order_address.phone_number  = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が半角数値でなければ出品できないこと' do
        @order_address.phone_number  = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が英数字混合では出品できないこと' do
        @order_address.phone_number  = 'abc12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が半角英字では出品できないこと' do
        @order_address.phone_number  = 'abcdefghijk'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'ユーザーが紐付いていなければ出品できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it '商品情報が紐付いていなければ出品できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
