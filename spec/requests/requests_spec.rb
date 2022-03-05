require 'rails_helper'

RSpec.describe "Requests", type: :request do
  let!(:user) {FactoryBot.create(:user)}

  describe "リクエスト新規作成" do

    context "ログインする場合" do
      before do
        sign_in(user)
      end

      context "適切な入力" do
        it "作成成功" do
          get mypage_path
          expect do
            post requests_path, params: {request: {request_name: "リクエストです。",
              request_detail: "リクエストの詳細です",
              reward: "報酬です。"}}
          end.to change {user.requests.count}.by(1)
        end
      end
  
      context "不適切な入力" do
        it "作成失敗" do
          get mypage_path
          expect do
           post requests_path, params: {request: {request_name: "",
             request_detail: "リクエストの詳細です",
             reward: "報酬です。"}}
          end.to change {user.requests.count}.by(0)
        end
      end

    end
  end

  describe "リクエスト削除" do
    let!(:request_1) {user.requests.create(request_name: "テストです。あれを借りたい。",
                                           request_detail: "テストの投稿です。",
                                           reward: "テストの報酬です。")}
  
    context "ログインしない場合" do
      it "ログインページへ" do
        expect do
          delete request_path(id: request_1.id)
        end.to change {Request.count}.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインする場合" do
      context "自分のリクエストの時" do
        before do
          sign_in(user)
        end

        it "削除成功" do
          expect do
            delete request_path(id: request_1.id)
          end.to change {Request.count}.by(-1)
          expect(response).to redirect_to mypage_url
        end
      end

      context "他人のリクエストの時" do
        before do
          other_user = User.create(name: "other_keigo",
                                   email: "other_test@ex.com",
                                   password: "password",
                                   confirmed_at: Date.today,
                                   created_at: Date.today,
                                  updated_at: Date.today)
          sign_in(other_user)
        end

        it "削除失敗" do
          expect do
            delete request_path(id: request_1.id)
          end.to change {Request.count}.by(0)
          expect(response).to redirect_to mypage_url
        end
      end

    end
  end

  describe "リクエスト詳細" do
    let!(:request_1) {user.requests.create(request_name: "テストです。あれを借りたい。",
      request_detail: "テストの投稿です。",
      reward: "テストの報酬です。")}

    context "ログインしない時" do
      it "詳細ページに入れない" do
        get request_path(request_1)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "リクエスト製作者でログイン" do
      before do
        sign_in(user)
      end

      it "詳細ページに入れる。削除とメッセージルーム一覧作成が存在する" do
        get request_path(request_1)
        expect(response).to have_http_status(200)
        expect(response.body).to include("削除")
        expect(response.body).to include("メッセージルーム一覧へ")
      end

    end

    context "関係ないユーザーでログイン" do
      before do
        other_user = User.create(name: "other_keigo",
          email: "other_test@ex.com",
          password: "password",
          confirmed_at: Date.today,
          created_at: Date.today,
         updated_at: Date.today)
        sign_in(other_user)
      end

      it "詳細ページに入れる。削除とメッセージルーム一覧作成が存在しない。貸せるが存在" do
        get request_path(request_1)
        expect(response).to have_http_status(200)
        expect(response.body).not_to include("削除")
        expect(response.body).not_to include("メッセージルーム一覧へ")
        expect(response.body).to include("貸せる")
      end
    end

  end
  
end
