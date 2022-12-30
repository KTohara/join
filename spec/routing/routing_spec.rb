require 'rails_helper'

RSpec.describe "routing", type: :routing do
  describe 'root' do
    it 'routes the root page' do
      expect(get: '/').to route_to(controller: 'posts', action: 'index')
    end
  end

  describe 'users' do
    it 'routes all user routes' do
      expect(get: 'users').to route_to(controller: 'users', action: 'index')
      expect(get: 'users/1').to route_to(controller: 'users', action: 'show', id: '1')
    end
  end

  describe 'posts' do
    it 'routes all post routes' do
      expect(get: 'posts').to route_to(controller: 'posts', action: 'index')
      expect(post: 'posts').to route_to(controller: 'posts', action: 'create')
      expect(put: 'posts/1').to route_to(controller: 'posts', action: 'update', id: '1')
      expect(patch: 'posts/1').to route_to(controller: 'posts', action: 'update', id: '1')
      expect(delete: 'posts/1').to route_to(controller: 'posts', action: 'destroy', id: '1')
    end
  end

  describe 'friendships' do
    it 'routes all friendship routes' do
      expect(get: 'friendships').to route_to(controller: 'friendships', action: 'index')
      expect(post: 'friendships').to route_to(controller: 'friendships', action: 'create')
      expect(put: 'friendships/1').to route_to(controller: 'friendships', action: 'update', id: '1')
      expect(patch: 'friendships/1').to route_to(controller: 'friendships', action: 'update', id: '1')
      expect(delete: 'friendships/1').to route_to(controller: 'friendships', action: 'destroy', id: '1')
    end
  end

  describe 'comments' do
    it 'routes all post comment routes' do
      expect(post: 'posts/1/comments').to route_to(controller: 'posts/comments', action: 'create', post_id: '1')
    end
    
    it 'routes all comment comment routes' do
      expect(post: 'comments/1/comments').to route_to(controller: 'comments/comments', action: 'create', comment_id: '1')
      expect(patch: 'comments/1').to route_to(controller: 'comments', action: 'update', id: '1')
      expect(put: 'comments/1').to route_to(controller: 'comments', action: 'update', id: '1')
      expect(delete: 'comments/1').to route_to(controller: 'comments', action: 'destroy', id: '1')
    end
  end

  describe 'likes' do
    it 'routes all post likes' do
      expect(post: 'posts/1/likes').to route_to(controller: 'posts/likes', action: 'create', post_id: '1')
      expect(delete: 'posts/1/likes/1').to route_to(controller: 'posts/likes', action: 'destroy', post_id: '1', id: '1')
    end

    it 'routes all post likes' do
      expect(post: 'comments/1/likes').to route_to(controller: 'comments/likes', action: 'create', comment_id: '1')
      expect(delete: 'comments/1/likes/1').to route_to(controller: 'comments/likes', action: 'destroy', comment_id: '1', id: '1')
    end
  end
end