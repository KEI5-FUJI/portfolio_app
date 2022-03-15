require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe "Requests", type: :request do
  describe "パスワードリセット" do
    let!(:user) { FactoryBot.create(:user) }
    before do
      @raw, enc = Devise.token_generator.generate(User, :reset_password_token)
      user.reset_password_token = enc
      user.reset_password_sent_at = Time.now.utc
      user.save(validate: false)
    end

    context "適切なメールアドレス入力" do
      it "変更用のメールが届く" do
        post user_password_path, params: {user: {email: user.email}}
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it "変更用メールに記載のurlを踏むと、パスワード変更ページへリダイレクト" do
        get edit_user_password_path
        travel_to(Time.current + 5.hours)
        patch user_password_path, params: {user: {password: 'newpass', password_confirmation: 'newpass', reset_password_token: @raw}}
        expect(User.first.valid_password? 'newpass').to eq true
        expect(response).to redirect_to requests_path
      end
    end

    context "不適切なメールアドレス入力" do
      it "メールが届かない" do
        post user_password_path, params: {user: {email: "wrongemail"}}
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end
    end

    
  end
end