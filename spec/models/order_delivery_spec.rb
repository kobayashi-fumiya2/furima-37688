require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @order_delivery = FactoryBot.build(:order_delivery)
  end
  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'postcode、prefecture_id、city、block、buildingm、phone_numberが正しい値で存在すれば登録できる' do
        expect(@order_delivery).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_delivery.building = nil
        expect(@order_delivery).to be_valid
      end
    end
    context '配送先情報の保存ができないとき' do
      it 'user_idが空では保存できない' do
        @order_delivery.user_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'Item_idが空では保存できない' do
        @order_delivery.item_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'postcodeが空では保存できない' do
        @order_delivery.postcode = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが「3桁ハイフン4桁」の半角文字列以外は保存できない' do
        @order_delivery.postcode = '2222-444'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postcode is invalid')
      end
      it 'prefecture_idが未選択では保存できない' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では保存できない' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空では保存できない' do
        @order_delivery.block = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberが空では保存できない' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値以外は保存できない' do
        @order_delivery.phone_number = '1,3-4a6-7@90'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが全角数字では保存できない' do
        @order_delivery.phone_number = '１２３４５６７８９９８'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが9桁以下では保存できない' do
        @order_delivery.phone_number = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが12桁以上では保存できない' do
        @order_delivery.phone_number = '123456789098'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では保存できない' do
        @order_delivery.token = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
