require 'rails_helper'

RSpec.describe Interview, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/jobs/1/candidates/1/interviews').to route_to(controller: 'interviews', action: 'index', job_id: '1', candidate_id: '1', format: :json)
  end
end