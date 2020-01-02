# frozen_string_literal: true

# configure as you wish
TOURNAMENTS_COUNT = 5
SEASON_FINISHED = false
QUARTERFINALS_FINISHED = false
SEMIFINALS_FINISHED = false
FINALS_FINISHED = false


Game.destroy_all
Tournament.destroy_all
Team.destroy_all
puts 'db cleared'


TOURNAMENTS_COUNT.times do |n|
  Tournament.create(name: "Tournament-#{n}", status: Random.rand(3))
end
puts 'tournaments created'


teams = []
16.times do |n|
  teams << Team.create(name: "Team No. #{sprintf('%02d', n)}")
end
teams = teams.shuffle # randomize team order before assigning to divisions
puts 'teams created'


# season games
Tournament.all.each do |tournament|
  Tournament::RegularSeasonGenerator.new(tournament.name, tournament, teams).call

  if SEASON_FINISHED
    Tournament::SeasonResultsGenerator.new(tournament).call
    Tournament::PlayoffGamesGenerator.new(tournament, :quarterfinal).call
  end

  if QUARTERFINALS_FINISHED
    Tournament::PlayoffResultsGenerator.new(tournament, :quarterfinal).call
    Tournament::PlayoffGamesGenerator.new(tournament, :semifinal).call
  end

  if SEMIFINALS_FINISHED
    Tournament::PlayoffResultsGenerator.new(tournament, :semifinal).call
    Tournament::PlayoffGamesGenerator.new(tournament, :final).call
  end

  if FINALS_FINISHED
    Tournament::PlayoffResultsGenerator.new(tournament, :final).call
  end
end
puts 'games created'
