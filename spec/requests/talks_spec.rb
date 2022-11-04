require 'rails_helper'

RSpec.describe 'Talks', type: :request do
  let!(:talks) { FactoryBot.create_list(:talk, 3) }

  describe 'GET /index' do
    it 'returns http success' do
      get talks_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get talk_path(talks.first)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_talk_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /talks' do
    it 'returns http success' do
      post talks_path, params: { talk: { name: 'MyString', initial_time: '09:00' } }
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST /create_by_csv' do
    it 'returns http success' do
      expect do
        post create_by_csv_talks_path, params: { talk: { file: file_fixture('valid_talks.csv')} }
      end.to change(Talk, :count).by(20)
        
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_talk_path(talks.first)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /talk' do
    it 'returns http success' do
      patch talk_path(talks.first), params: { talk: { name: 'MyString', initial_time: '09:00' } }
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE /talk' do
    it 'returns http success' do
      delete talk_path(talks.first)
      expect(response).to have_http_status(302)
    end
  end
end
