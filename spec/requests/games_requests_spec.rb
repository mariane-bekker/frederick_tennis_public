require 'rails_helper'

RSpec.describe GamesController, type: :request do
  let(:server_name) { 'Venus' }
  let(:receiver_name) { 'Serena' }
  let(:request_headers) { { 'Content-Type' => 'application/json' } }

  let(:game) { Game.create!(server_name: server_name, receiver_name: receiver_name) }

  context 'POST /games/:id/score' do
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
      [5, 7, 'Game Serena'],
    ].each do |test_case|
      server_score, receiver_score, called_score = test_case

      it "correctly scores #{server_score}-#{receiver_score} as #{called_score}" do
        server_score.times do
          post "/games/#{game.id}/score", params: server_name, headers: request_headers
          expect(response).to be_success
        end

        receiver_score.times do
          post "/games/#{game.id}/score", params: receiver_name, headers: request_headers
          expect(response).to be_success
        end

        get "/games/#{game.id}"

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['called_score']).to eq called_score
      end
    end
  end
end
