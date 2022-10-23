require 'rails_helper'

RSpec.describe 'Tracks', type: :request do
  let!(:tracks) { FactoryBot.create_list(:track, 3) }

  describe 'GET /' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get tracks_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get track_path(tracks.first)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_track_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /tracks' do
    it 'returns http success' do
      post tracks_path, params: { track: { name: 'MyString' } }
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_track_path(tracks.first)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /track' do
    it 'returns http success' do
      patch track_path(tracks.first), params: { track: { name: 'MyString' } }
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE /track' do
    it 'returns http success' do
      delete track_path(tracks.first)
      expect(response).to have_http_status(302)
    end
  end
end
