require 'rails_helper'

RSpec.describe "routing", type: :routing do
  describe 'root' do
    it 'routes the root page' do
      expect(get: '/').to route_to(controller: 'posts', action: 'index')
    end
  end

  describe 'users' do
    it 'correctly routes all user routes' do
      expect(get: 'users').to route_to(controller: 'users', action: 'index')
      expect(get: 'users/1').to route_to(controller: 'users', action: 'show', id: '1')
    end
  end

  describe 'posts' do
    it 'correctly routes all post routes' do
      expect(get: 'posts').to route_to(controller: 'posts', action: 'index')
      expect(post: 'posts').to route_to(controller: 'posts', action: 'create')
      expect(put: 'posts/1').to route_to(controller: 'posts', action: 'update', id: '1')
      expect(patch: 'posts/1').to route_to(controller: 'posts', action: 'update', id: '1')
      expect(delete: 'posts/1').to route_to(controller: 'posts', action: 'destroy', id: '1')
    end
  end

  describe 'friendships' do
    it 'correctly routes all friendship routes' do
      expect(get: 'friendships').to route_to(controller: 'friendships', action: 'index')
      expect(post: 'friendships').to route_to(controller: 'friendships', action: 'create')
      expect(put: 'friendships/1').to route_to(controller: 'friendships', action: 'update', id: '1')
      expect(patch: 'friendships/1').to route_to(controller: 'friendships', action: 'update', id: '1')
      expect(delete: 'friendships/1').to route_to(controller: 'friendships', action: 'destroy', id: '1')
    end
  end

  describe 'comments' do
    it 'correctly routes all comment routes' do
      expect(post: 'posts/1/comments').to route_to(controller: 'comments', action: 'create', post_id: '1')
      expect(patch: 'posts/1/comments/1').to route_to(controller: 'comments', action: 'update', post_id: '1', id: '1')
      expect(put: 'posts/1/comments/1').to route_to(controller: 'comments', action: 'update', post_id: '1', id: '1')
      expect(delete: 'posts/1/comments/1').to route_to(controller: 'comments', action: 'destroy', post_id: '1', id: '1')
    end
  end
end