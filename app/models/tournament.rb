# frozen_string_literal: true

class Tournament < ApplicationRecord
  # include ActiveModel::Validations
  # validates_with SixteenTeamsValidator
  # validate :sixteen_teams_present
  validates :name, uniqueness: { case_sensitive: true }, presence: true

  has_many :games, -> { order("name ASC") }, dependent: :destroy
  has_many :guest_teams, through: :games, source: :guest_team
  has_many :host_teams, through: :games, source: :host_team

  has_many :tournament_entries, dependent: :destroy
  has_many :teams, -> { order('tournament_entries.total_points DESC, tournament_entries.total_goals DESC') }, through: :tournament_entries

  enum status: [:draft, :in_progress, :done]

  def host_teams
    super.distinct.order(:name)
  end

  def guest_teams
    super.distinct.order(:name)
  end

  def tournament_entries
    super.order('total_points DESC, total_goals DESC')
  end

  # these methods needs querying optimization
  def teams_by_division(division_number)
    host_teams.where(host_games: games.where("division = #{division_number}"))
  end

  def game_for(guest_team, division_number, opponent_position)
    games.find_by(guest_team_id: guest_team.id,
                  host_team_id: host_teams.where(host_games: games
                                          .where("division = #{division_number}"))[opponent_position])
  end

  def playoff_level
    games.map { |game| game.read_attribute_before_type_cast(:playoff_level) }.max ||
      0
  end

  # ???????
  def playoff_winners(playoff_level)
    games.send(playoff_level).map(&:winner)
  end

  # def playoff_games(playoff_level)
  #   games.send
  # end
end
