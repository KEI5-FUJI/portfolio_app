require 'rails_helper'

RSpec.describe "HomePages", type: :request do
  let(:user) {FactoryBot.create(:user)}

  describe "マイページにおける操作" do
    context "ログインしていない場合" do
      it "ログインページへ強制移動" do
        get mypage_path
        expect(response).to redirect_to new_user_session_url 
      end
    end
    
    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "マイページに入れる" do
        get mypage_path
        expect(response).to have_http_status(200)
      end

      context "投稿に成功するとき" do
        it "投稿ができる" do
          get mypage_path
          # expect(response.body).to include(request.request_name)
          # expect(response.body).to include(request.request_detail)
          post requests_path, params: {request: {request_name: "リクエストです",
                                                request_detail: "リクエストの詳細です。",
                                                reward: "報酬です。"}}
          expect(response).to redirect_to mypage_path
          expect(response.body).to include("リクエストです")
          expect(response.body).to include("リクエストの詳細です")
          expect(response.body).to include("報酬です。")
        end
      end

      context "投稿に成功するとき" do
        it "投稿ができない" do
          post requests_path, params: {request: {request_name: "",
                                                request_detail: "リクエストの詳細です。",
                                                reward: "報酬です。"}}
          expect(response.body).not_to include("リクエストの詳細です")
          expect(response.body).not_to include("報酬です。")
        end
      end

    end
  end
end
