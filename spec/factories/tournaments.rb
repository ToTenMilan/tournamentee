# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    sequence :name, 100 do |num|
      "Tournament No. #{num}"
    end
    status { 0 }
  end

  factory :tournament_with_games_light, parent: :tournament do
    transient do
      games_count { 8 }
    end

    before(:create) do |tournament, evaluator|
      evaluator.games_count.times do
        tournament.games << build(:game)
      end
    end
  end

  factory :tournament_with_games, parent: :tournament do
    after(:create) do |tournament, _evaluator|
      teams = create_list(:team, 16)
      generate_games(tournament, teams[0, 8], :a)
      generate_games(tournament, teams[8, 15], :b)
    end
  end

  factory :tournament_with_finished_season, parent: :tournament do
    transient do
      teams_count { 8 }
    end
    after(:create) do |tournament, evaluator|
      teams = create_list(:team, evaluator.teams_count)
      tournament.teams << teams
      teams.each_with_index do |team, index|
        team.tournament_entries.first.update(total_points: index % (evaluator.teams_count / 2),
                                             total_goals: index + 1,
                                             division: index < evaluator.teams_count / 2 ? 'a' : 'b') # div a: 0,1,2,3 | div b: 0,1,2,3
      end
    end
  end

  factory :tournament_with_games_with_season_results, parent: :tournament do
    after(:create) do |tournament, _evaluator|
      teams = create_list(:team, 4)
      generate_games(tournament, teams[0, 2], :a)
      generate_games(tournament, teams[2, 3], :b)
      generate_results_for_season_games(tournament)
    end
  end

  factory :tournament_with_playoff_games_generated, parent: :tournament do
    transient do
      games_needed { nil }
      playoff_level { nil }
    end
    after(:create) do |tournament, evaluator|
      teams = create_list(:team, 8)
      evaluator.games_needed.times do |n|
        tournament.games.create(host_team_id: teams[n * 2].id,
                                guest_team_id: teams[n * 2 + 1].id,
                                playoff_level: evaluator.playoff_level,
                                game_type: :playoff)
      end
    end
  end


  factory :tournament_with_finished_quarterfinal, parent: :tournament do
    after(:create) do |tournament, evaluator|
      teams = create_list(:team, 8)
      4.times do |n|
        tournament.games.create(host_team_id: teams[n * 2].id,
          guest_team_id: teams[n * 2 + 1].id,
          playoff_level: :quarterfinal,
          game_type: :playoff,
          name: "Game #{n + 1}",
          host_team_result: 3-n, # host wins in n=[0,1]
          guest_team_result: n) # guest wins in n = [2,3]
      end
    end
  end

  factory :tournament_with_finished_semifinal, parent: :tournament do
    after(:create) do |tournament, evaluator|
      teams = create_list(:team, 4)
      2.times do |n|
        tournament.games.create(host_team_id: teams[n * 2].id,
          guest_team_id: teams[n * 2 + 1].id,
          playoff_level: :semifinal,
          game_type: :playoff,
          name: "Game #{n + 1}",
          host_team_result: 1-n, # host wins in n=0
          guest_team_result: n) # guest wins in n=1
      end
    end
  end
end
