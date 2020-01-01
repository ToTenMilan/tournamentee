# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TournamentsController', type: :request do
  context 'GET #new' do
    it 'should show form for new team' do
      get '/teams/new'  
      expect(assigns(:team)).to be_instance_of Team
    end
  end

  context 'POST #create' do
    it 'should create new team' do
      expect {
        post '/teams', params: { team: { name: 'Hawks' } }
      }.to change(Team, :count).by 1
      expect(flash[:success]).to match(/Team souccessfully created/)
      expect(response).to redirect_to("/tournaments")
    end

    it 'should not create new team if its not valid' do
      team = build(:team) do |t|
        t.name = 'Hawks'
        t.save
      end
      expect {
        post '/teams', params: { team: { name: 'Hawks' } }
      }.to change(Team, :count).by 0
      expect(response).to render_template(:new)
    end
  end
end
