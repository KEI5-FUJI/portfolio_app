require 'rails_helper'

RSpec.describe Request, type: :model do
   describe "リクエストのモデルのバリテーション" do
     let(:request) {FactoryBot.build(:request)}
     subject {request.valid?}

     context "リクエスト名が50文字以上の時" do
        it "失敗" do
          request.request_name = "a"*51
          is_expected.to eq false
        end
     end

     context "リクエスト名が0文字の時" do
        it "失敗" do
          request.request_name = ""
          is_expected.to eq false
        end
     end

     context "リクエスト名が1文字以上50字以内の時" do
        it "成功" do
          request.request_name = "a"*50
          is_expected.to eq true
        end
     end

     context "リクエスト詳細が300字以上の時" do
        it "失敗" do
          request.request_detail = "a"*301
          is_expected.to eq false
        end
     end

     context "リクエスト詳細が空白の時" do
        it "失敗" do
          request.request_detail = ""
          is_expected.to eq false
        end
     end
     
     context "リクエスト詳細が1文字以上300字以内の時" do
        it "成功" do
          request.request_detail = "a"*300
          is_expected.to eq true
        end
     end

     context "報酬が100文字以上の時" do
        it "失敗" do
          request.reward = "a"*101
          is_expected.to eq false
        end
     end

     context "報酬が100文字以内の時" do
        it "成功" do
          request.reward = "a"*100
          is_expected.to eq true
        end
     end

     context "報酬が空白の時" do
        it "成功" do
          request.reward = ""
          is_expected.to eq true
        end
     end
     
   end
end
