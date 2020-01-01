class Tournament
  class SixteenTeamsValidator < ActiveModel::Validator
    def validate(record)
      if record.teams.size != 16
        record.errors.add(:base, "Tournament must have 16 teams assigned on order to be created")
      end
    end
  end
end