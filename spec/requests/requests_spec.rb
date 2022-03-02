require 'rails_helper'

RSpec.describe "Requests", type: :request do
  describe "リクエスト新規作成" do
    context "適切な入力" do
      it "作成成功後元のリクエスト一覧ページに戻る" do
        get requests_path
        post request_path()
      end
    end
  end

end
