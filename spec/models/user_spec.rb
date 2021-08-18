require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザ登録ができる時' do 
      it '全ての情報が存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上であれば登録できること' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
    end

    context 'ユーザ登録ができない時' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end


      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
  
      it 'emailに＠がなければ登録できないこと' do
        @user.email = 'testexample'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

  
      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
  
      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = '123ab'
        @user.password_confirmation ='12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
  
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが半角英語のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordが数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

  
      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外は登録できないこと' do
        @user.last_name = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

  
      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外は登録できないこと' do
        @user.first_name = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

  
      it 'last_name_kanaが空では登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
    
      it 'last_name_kanaが全角（カタカナ）以外は登録できない' do
        @user.last_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end


      it 'first_name_kanaが空では登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが全角（カタカナ）以外は登録できない' do
        @user.first_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

  
      it 'birth_dateが空では登録できないこと' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end

  end

end