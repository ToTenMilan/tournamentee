# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TournamentEntry, type: :model do
  it 'is unique among tournament and team' do
    tournament = create(:tournament)
    team = create(:team)
    tournament.teams << team
    expect { tournament.teams << team }.to raise_error(an_instance_of(ActiveRecord::RecordNotUnique))
  end
end