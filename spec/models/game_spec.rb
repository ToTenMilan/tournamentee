# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'is unique among tournament, guest_team and host_team' do
    create(:game)
    expect {
      create(:duplicated_game)
    }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid).and having_attributes(message: "Validation failed: Tournament already has this game"))
  end
end
