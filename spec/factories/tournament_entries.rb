# frozen_string_literal: true

FactoryBot.define do
  factory :tournament_entry do
    tournament
    team
  end
end
