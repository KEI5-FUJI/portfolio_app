require 'rails_helper'

RSpec.describe "Messagerooms", type: :request do
  let!(:user) {FactoryBot.create(:user)}
  before do
    @other_user = User.create(name: "other_keigo",
                             email: "other_test@ex.com", 
                             password: "password", 
                             confirmed_at: Date.today, 
                             created_at: Date.today, 
                             updated_at: Date.today)
  end

  let!(:request_1) {user.requests.create(request_name: "テストです。あれを借りたい。",
    request_detail: "テストの投稿です。",
    reward: "テストの報酬です。")}

  describe "メッセージルーム一覧" do
    before do
      request_1.messagerooms.create(owner_id: user.id, guest_id: @other_user.id)
    end

    context "ログインしない場合" do
      it "マイページに戻される" do
        get request_messagerooms_path(request_id: request_1.id)
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "リクエスト作成者でログイン" do
      before do
        sign_in user
      end

      it "入れる、メッセージルームが存在" do
        get request_messagerooms_path(request_id: request_1.id)
        expect(response).to include(@other_user.name)
        #メッセージルーム一覧表示
      end
    end
    
    context "非リクエスト作成者でログイン" do
      before do
        sign_in @other_user
      end

      it "入れない" do
        get request_messagerooms_path(request_id: request_1.id)
        expect(response).to redirect_to mypage_url  
      end
    end
    
  end
  
  describe "メッセージルーム作成" do

    context "ログインしない場合" do
      it "マイページへ" do
         expect do
          post request_messagerooms_path(request_id: request_1.id)
         end.to change {Messageroom.count}.by(0)
         expect(response).to redirect_to new_user_session_url
      end
    end

    context "ログインする場合" do
       context "リクエスト作成者でログイン" do
         before do
          sign_in user
         end

         it "作成失敗し、詳細ページがレンダー" do
            expect do
              post request_messagerooms_path(request_id: request_1.id)
            end.to change {Messageroom.count}.by(0)
            #レンダー
         end
       end

       context "非リクエスト作成者でログイン" do
         before do
          sign_in @other_user
         end

         it "作成成功し、メッセージルームに入る" do
            expect do
              post request_messagerooms_path(request_id: request_1.id)
            end.to change {Messageroom.count}.by(1)
            expect(response).to redirect_to request_messageroom_url(request_id: request_1.id, id: Messageroom.first.id)
            #メッセージルーム内
         end
       end
    end
  end

end
