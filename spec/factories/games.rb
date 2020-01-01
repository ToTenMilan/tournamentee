# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    tournament
    host_team
    guest_team
    sequence :name, 100 do |num|
      "Game No. #{num}"
    end
    game_type { 0 }
    guest_team_result { nil }
    host_team_result { nil }
    playoff_level { 0 }
    division { 0 }
  end

  factory :duplicated_game, class: Game do
    tournament { Tournament.first }
    host_team { Team.first }
    guest_team { Team.second }
    playoff_level { 0 }
  end
end
