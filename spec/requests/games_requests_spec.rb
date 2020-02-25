require 'rails_helper'

RSpec.describe GamesController, type: :request do
  let(:server_name) { 'Venus' }
  let(:receiver_name) { 'Serena' }
  let(:request_headers) { { 'Content-Type' => 'application/json' } }
  let(:game) { Game.create!(server_name: server_name, receiver_name: receiver_name) }

  describe 'POST /games/:id/score' do
    [
        [0, 0, 'Love all'],
        [1, 1, '15 all'],
        [2, 2, '30 all'],
        [3, 3, 'Deuce'],
        [4, 4, 'Deuce'],
        [0, 1, 'Love 15'],
        [1, 0, '15 love'],
        [13, 13, 'Deuce'],
        [19, 20, 'Advantage out'],
        [5, 4, 'Advantage in'],
        [4, 3, 'Advantage in'],
        [3, 1, '40 10'],
        [5, 3, 'Game Venus'],
        [5, 7, 'Game Serena']
    ].each do |test_case|
      server_score, receiver_score, called_score = test_case

      it "correctly scores #{server_score}-#{receiver_score} as #{called_score}" do
        server_score.times do
          post "/games/#{game.id}/score", params: {score: server_name}.to_json, headers: request_headers
          expect(response).to be_successful
        end

        receiver_score.times do
          post "/games/#{game.id}/score", params: {score: receiver_name}.to_json, headers: request_headers
          expect(response).to be_successful
        end

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['called_score']).to eq called_score
      end
    end
  end

  describe 'GET /games/:id' do
    let(:server_score) { 0 }
    let(:receiver_score) { 0 }
    let(:called_score) { "Love all" }
    let(:game) { Game.create!(server_name: server_name, receiver_name: receiver_name, server_score: server_score, receiver_score: receiver_score) }
    let(:game_attrs) do
      {"server_name" => game.server_name, "receiver_name" => game.receiver_name, "server_score" => game.server_score,
       "receiver_score" => game.receiver_score, "id" => game.id, "called_score" => called_score }
    end

    it 'returns attributes of game, including called score' do
      get "/games/#{game.id}"

      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq({"game" => game_attrs})
    end
  end

  describe 'POST /games' do
    let(:called_score) { "Love all" }
    let(:params) { { server_name: server_name, receiver_name: receiver_name } }
    let(:game_attrs) do
      {"server_name" => game.server_name, "receiver_name" => game.receiver_name, "server_score" => game.server_score,
       "receiver_score" => game.receiver_score, "called_score" => called_score }
    end

    before { post '/games', params: { server: server_name, receiver: receiver_name }.to_json, headers: request_headers }

    it "creates a new game" do
      expect(response).to be_successful
    end

    it 'returns the expected response' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body['game']['id']).not_to be_nil
      expect(parsed_body['game'].include?(game_attrs)).to be true
    end
  end
end