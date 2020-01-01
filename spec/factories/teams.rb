# frozen_string_literal: true

FactoryBot.define do
  factory :team, class: Team do
    sequence :name, 100 do |num|
      "Team No. #{num}"
    end
  end

  factory :host_team, parent: :team do
    sequence :name, 100 do |num|
      "Host Team No. #{num}"
    end
  end

  factory :guest_team, parent: :team do
    sequence :name, 100 do |num|
      "Guest Team No. #{num}"
    end
  end
end
