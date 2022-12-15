require 'rails_helper'

RSpec.describe "routing", type: :routing do
  describe 'root' do
    it 'routes the root page' do
      expect(get: '/').to route_to(controller: 'posts', action: 'index')
    end
  end

  describe 'posts' do
    it 'correctly routes all post resources' do
      expect(get: 'posts').to route_to(controller: 'posts', action: 'index')
      expect(post: 'posts').to route_to(controller: 'posts', action: 'create')
      expect(put: 'posts/1').to route_to(controller: 'posts', action: 'update', id: '1')
      expect(patch: 'posts/1').to route_to(controller: 'posts', action: 'update', id: '1')
      expect(delete: 'posts/1').to route_to(controller: 'posts', action: 'destroy', id: '1')
    end
  end
end