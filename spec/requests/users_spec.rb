require 'rails_helper'

RSpec.describe "Requests", type: :request do
  describe "新規登録" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    

    before do
      ActionMailer::Base.deliveries.clear
    end

    context "正しく新規登録するとき" do
      it "メールが送られる" do
        get new_user_registration_path
        post user_registration_path, params: {user: {email: "email@ex.com",
                                                     password: "password",
                                                     password_confirmation: "password"}}
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it "createが成功" do
        expect do
          post user_registration_path, params: {user: {email: "email@ex.com",
                                                       password: "password",
                                                       password_confirmation: "password"}}
        end.to change {User.count}.by(1)
      end

      it "ルートへ移動" do
        post user_registration_path, params: {user: {email: "email@ex.com",
                                                     password: "password",
                                                     password_confirmation: "password"}}
        expect(response).to redirect_to root_url
      end
    end

    context "間違って新規登録(メールが不適切するとき)" do
      it "メールが送られない" do
        get new_user_registration_path
        post user_registration_path, params: {user: {email: "",
                                                     password: "password",
                                                     password_confirmation: "password"}}
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it "createが失敗" do
        expect do
          post user_registration_path, params: {user: {email: "",
                                                       password: "password",
                                                       password_confirmation: "password"}}
        end.to change {User.count}.by(0)
      end
    end
    
  end
  
end