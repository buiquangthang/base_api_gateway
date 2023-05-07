# frozen_string_literal: true

describe SessionsController do
  let(:user) { create(:user) }
  let(:login_url) { '/sign_in' }

  context 'when logging in' do
    before do
      login(user)
    end

    it 'returns a token' do
      expect(response.body['auth_token']).to be_present
    end

    it 'returns 200' do
      expect(response).to have_http_status(:created)
    end
  end

  context 'when email is missing' do
    before do
      post login_url, params: {
        auth: {
          email: nil,
          password: user.password
        }
      }
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when password is missing' do
    before do
      post login_url, params: {
        auth: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
