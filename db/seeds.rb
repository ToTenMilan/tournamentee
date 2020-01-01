# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Game.destroy_all
Tournament.destroy_all
Team.destroy_all
puts 'db cleared'

TOURNAMENTS_COUNT = 3

TOURNAMENTS_COUNT.times do |n|
  Tournament.create(name: "Tournament-#{n}", status: Random.rand(3))
end
puts 'tournaments created'

teams = []
16.times do |n|
  teams << Team.create(name: "Team No. #{sprintf('%02d', n)}")
end
puts 'teams created'

# season games
Tournament.all.each do |tournament|
  teams = teams.shuffle # randomize teams before asigning to divisions
  Tournament::RegularSeasonGenerator.new(tournament.name, tournament, teams).call
  Tournament::SeasonResultsGenerator.new(tournament).call
  Tournament::PlayoffGamesGenerator.new(tournament, :quarterfinal).call
  # Tournament::PlayoffResultsGenerator.new(tournament).call
end
puts 'games created'
