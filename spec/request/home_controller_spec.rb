# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :request do
  context 'GET #index' do
    it 'should respond with 200' do
      get '/'
      expect(response.status).to be 200
    end
  end
end