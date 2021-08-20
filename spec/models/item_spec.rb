require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '出品機能の実装' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '出品ができる場合' do
      it '全ての情報が存在すれば出品できること' do
        expect(@item).to be_valid
      end

      it '価格が¥300~¥9,999,999の間ならば出品できること' do
        @item.price = 10000
        expect(@item).to be_valid
      end

    end


    context '出品ができない場合' do

      it '商品画像が空では出品できないこと' do
        @item.image.attach(nil)
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では出品できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では出品できないこと' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it 'カテゴリーが空では出品できないこと' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が空では出品できないこと' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担が空では出品できないこと' do
        @item.shipping_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it '発送元の地域が空では出品できないこと' do
        @item.prefecture_id  = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が空では出品できないこと' do
        @item.scheduled_delivery_id  = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      it '価格が空では出品できないこと' do
        @item.price  = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end 

      it '価格が¥300未満の場合は出品できないこと' do
        @item.price  = 299
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price must be greater than or equal to 300")
      end

      it '価格が¥10,000,000以上の場合は出品できないこと' do
        @item.price  = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include ("Price must be less than or equal to 9999999")
      end

      it '価格が半角数値でなければ出品できないこと' do
        @item.price  = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が英数字混合では出品できないこと' do
        @item.price  = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が半角英字では出品できないこと' do
        @item.price  = 'abcde'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'ユーザーが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
