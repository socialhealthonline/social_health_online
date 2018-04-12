require 'rails_helper'

RSpec.describe Console::NewsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/console/news').to route_to('console/news#index')
    end

    it 'routes to #new' do
      expect(get: '/console/news/new').to route_to('console/news#new')
    end

    it 'routes to #show' do
      expect(get: '/console/news/1').to route_to('console/news#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/console/news/1/edit').to route_to('console/news#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/console/news').to route_to('console/news#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/console/news/1').to route_to('console/news#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/console/news/1').to route_to('console/news#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/console/news/1').to route_to('console/news#destroy', id: '1')
    end

  end
end
