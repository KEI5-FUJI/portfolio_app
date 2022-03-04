require 'rails_helper'

RSpec.describe "Requests", type: :request do
  let!(:user1) {FactoryBot.create(:user)}

  describe "ログイン" do
    context "正常にログインするとき" do
      it "ログイン後リクエスト一覧へ" do
        get  login_path
        post new_login_path, params: {user: {email: "email@ex.com",
                                                password: "password"}}
        expect(response).to redirect_to requests_path  
      end 
    end

    context "ログインに失敗するとき" do
      it "ログイン失敗し、再びログインページへ" do
        get login_path
        post new_login_path, params: {user: {email: "wrong_email@ex.com",
                                             password: "password"}}
        expect(response.body).to include("ログイン")
      end

      it "ログイン失敗し、再びログインページへ" do
        get login_path
        post new_login_path, params: {user: {email: "email@ex.com",
                                             password: "wrong_password"}}
        expect(response.body).to include("ログイン")
      end
    end
  end
  
end